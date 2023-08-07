package com.kkm.fyp.host.services

import com.kkm.fyp.host.dtos.StockResponse
import com.kkm.fyp.host.dtos.UserInfo
import com.kkm.fyp.host.exception.UserAlreadyRegisteredException
import com.kkm.fyp.host.exception.UserNotFoundException
import com.kkm.fyp.host.models.*
import com.kkm.fyp.host.repositories.UserRepository
import com.kkm.fyp.host.securities.jwt.JwtTokenProvider
import com.kkm.fyp.host.utils.from
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.lang.IllegalArgumentException
import java.time.LocalDate
import java.util.Date

@Service
class UserService(private val userRepository: UserRepository,
                  private val passwordEncoderApi: PasswordEncoder,
                  private val authenticationManager: AuthenticationManager,
                  private val jwtTokenProvider: JwtTokenProvider) {

    fun createUser(email: String, password: String, shopName: String?) {
        if (userRepository.findUserByEmail(email) != null) {
            throw UserAlreadyRegisteredException("User already registered")
        }
        val user = User(email = email, password = passwordEncoderApi.encode(password), shopName = shopName)
        userRepository.save(user)
    }

    fun getUser(email: String): UserInfo {
        val user = getUserByEmail(email)
        return getTokenUserInfo(email, user.id)
    }

    fun login(email: String, password: String): UserInfo {
        val normalizedEmail = email.lowercase()
        authenticationManager.authenticate(
            UsernamePasswordAuthenticationToken(
                normalizedEmail,
                password
            )
        )
        val user = getUserByEmail(email)
        return getTokenUserInfo(normalizedEmail, user.id)
    }

    fun addStock(name: String, price: Double, email: String, quantity: Int, id: String): UserInfo {
        val user = getUserByEmail(email)
        val newList = user.stocks.toMutableList()
        var index = newList.indexOfFirst { it.id == id }
        val stock = Stock(name = name, price = price, quantity = quantity, id = id)
        if (index < 0) {
            newList.add(stock)
        }else {
            newList[index] = stock
        }
        user.stocks = newList
        userRepository.save(user)
        return getTokenUserInfo(email, user.id)
    }

//    fun addItem(email: String, stockId: String, itemId: String): UserInfo {
//        val user = getUserByEmail(email)
//        val stocks = user.stocks
//        val stock = getStockByStockId(stockId, stocks)
//        val items = stock.items.toMutableList()
//        items.add(Item(id = itemId))
//        val index = stocks.indexOfFirst { it.id == stockId }
//        stocks[index].items = items
//        user.stocks = stocks
//        userRepository.save(user)
//        return getTokenUserInfo(email, user.id)
//    }

    fun createTransaction(email: String, transactionItem: List<TransactionItem>, transactionId: String): String {
        val user = getUserByEmail(email)
        val transaction = Transaction(
            id = transactionId,
            transactionItems = transactionItem,
            shopId = user.id,
            date = LocalDate.now().toString(),
            customerId = null,
            isPaid = false,
            shopName = user.shopName!!
        )
        val transactions = user.transactions.toMutableList()
        transactions.removeIf { !it.isPaid }
        transactions.add(transaction)
        user.transactions = transactions
        userRepository.save(user)
        return transaction.id
    }

    fun getTransactionById(id: String, email: String): Transaction? {
        val user = getUserByEmail(email)
        return getTransactionById(id, transactions = user.transactions)
    }

    fun getTransactionByCustomer(id: String, shopId: String): Transaction? {
        val user = getUserById(shopId)
        return getTransactionById(id, transactions = user!!.transactions)
    }

    private fun getTransactionById(id: String, transactions: List<Transaction>): Transaction? {
        return transactions.find { it.id == id }
    }

    private fun getUserById(id: String): User? {
        return userRepository.findUserById(id)
    }

//    fun getStockByItemId(email: String, itemId: String): StockResponse? {
//        val user = getUserByEmail(email)
//        val stocks = user.stocks
//        val stock = getStockByItemId(itemId, stocks) ?: return null
//        return StockResponse(stock)
//    }

    private fun getTokenUserInfo(email: String, id: String):UserInfo {
        return UserInfo(email = email, id = id)
            .from(userRepository.findUserByEmail(email)!!)
            .apply {
                this.token = jwtTokenProvider.generateToken(email)
            }
    }

    private fun getStockByStockId(id: String, stocks: List<Stock>): Stock {
        return stocks.find { it.id == id }!!
    }

//    private fun getStockByItemId(id: String, stocks: List<Stock>): Stock? {
//        return stocks.find { stock ->
//            stock.items.any { item ->
//                item.id == id
//            }!!
//        }
//    }

    private fun getUserByEmail(email: String): User {
        return userRepository.findUserByEmail(email) ?: throw UserNotFoundException("User not found")
    }

    fun topUp(amount: Number, email: String): UserInfo? {
        val user = getUserByEmail(email)
        val currentAmount = user.walletAmount.toDouble() + amount.toDouble()
        user.walletAmount = currentAmount
        userRepository.save(user)
        return getTokenUserInfo(user.email, user.id)
    }

    fun pay(shopId: String, customerId: String, transactionId: String): UserInfo? {
        val shopUser = getUserById(shopId)
        val customer = getUserById(customerId)
        val transaction = getTransactionById(transactionId, shopUser!!.transactions)
        val price = getTransactionAmount(transaction!!).toDouble()

        return if (customer!!.walletAmount.toDouble() < price) {
            null
        }else {
            val newTransaction = transaction.copy(isPaid = true, customerId = customerId)
            var customerTransactions = customer.transactions.toMutableList()
            var shopTransactions = shopUser.transactions.toMutableList()
            val index = shopTransactions.indexOfFirst { it.id == transactionId }
            shopTransactions[index] = newTransaction
            customerTransactions.add(newTransaction)
            userRepository.save(shopUser.copy(
                transactions = shopTransactions,
                walletAmount = shopUser.walletAmount.toDouble() + price))
            userRepository.save(customer.copy(
                transactions = customerTransactions,
                walletAmount = customer.walletAmount.toDouble() - price))
            getTokenUserInfo(customer.email, customer.id)
        }

    }

    private fun getTransactionAmount(transaction: Transaction): Number {
        var sum = 0.0
        for (item in transaction.transactionItems) {
            sum += item.price.toDouble() * item.quantity.toDouble()
        }
        return sum
    }
}