package com.kkm.fyp.host.controllers

import com.kkm.fyp.host.dtos.*
import com.kkm.fyp.host.models.Transaction
import com.kkm.fyp.host.models.User
import com.kkm.fyp.host.repositories.UserRepository
import com.kkm.fyp.host.services.UserService
import org.springframework.http.ResponseEntity
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping(value = ["api/v1/users"])
class UserController(private val userService: UserService) {

    @PostMapping(value = ["/register"])
    fun createUser(@RequestBody userRegisterRequest: UserRegisterRequest): ResponseEntity<String> {
        userService.createUser(email = userRegisterRequest.email, password = userRegisterRequest.password, shopName = userRegisterRequest.shopName)
        return ResponseEntity.ok("User created")
    }

    @PostMapping(value = ["/login"])
    fun loginUser (@RequestBody userCredential: UserCredential): ResponseEntity<UserInfo> {
        return ResponseEntity.ok(userService.login(userCredential.email, userCredential.password))
    }

    @GetMapping(value = ["/me"])
    fun getUser(): ResponseEntity<UserInfo> {
        return ResponseEntity.ok(userService.getUser(SecurityContextHolder.getContext().authentication.name))
    }

    @PostMapping(value = ["/topup"])
    fun topUp(@RequestBody topUpRequest: TopUpRequest): ResponseEntity<UserInfo> {
        return ResponseEntity.ok(userService.topUp(amount = topUpRequest.amount, email = SecurityContextHolder.getContext().authentication.name))
    }

    @PostMapping(value = ["/stock"])
    fun addStock (@RequestBody addStockRequest: AddStockRequest): ResponseEntity<UserInfo> {
        return ResponseEntity.ok(userService.addStock(
            id = addStockRequest.id,
            quantity = addStockRequest.quantity,
            name = addStockRequest.name,
            price = addStockRequest.price,
            email = SecurityContextHolder.getContext().authentication.name))
    }



//    @PostMapping(value = ["/stock/item"])
//    fun addItem(@RequestBody addItemRequest: AddItemRequest): ResponseEntity<UserInfo> {
//        return ResponseEntity.ok(userService.addItem(email = SecurityContextHolder.getContext().authentication.name, stockId = addItemRequest.stockId, itemId = addItemRequest.itemId))
//    }

    @PostMapping(value = ["/checkout/create"])
    fun createCheckout(@RequestBody checkoutRequest: CheckoutRequest): ResponseEntity<String> {
        return ResponseEntity.ok(userService.createTransaction(
            email = SecurityContextHolder.getContext().authentication.name,
            transactionItem = checkoutRequest.transactionItems,
            transactionId = checkoutRequest.transactionId))
    }

    @GetMapping(value = ["/transaction"])
    fun getTransaction(@RequestParam id: String): ResponseEntity<Transaction> {

        return ResponseEntity.ok(userService.getTransactionById(id, email = SecurityContextHolder.getContext().authentication.name))
    }

    @PostMapping(value = ["/transaction"])
    fun getTransactionByCustomer(@RequestBody customerTransactionRequest: CustomerTransactionRequest): ResponseEntity<Transaction> {
        return ResponseEntity.ok(userService.getTransactionByCustomer(customerTransactionRequest.transactionId, customerTransactionRequest.shopId))
    }

    @PostMapping(value = ["/transaction/pay"])
    fun payTransaction(@RequestBody paymentRequest: PaymentRequest): ResponseEntity<UserInfo?> {
        return ResponseEntity.ok(userService.pay(
            shopId = paymentRequest.shopId,
            customerId = paymentRequest.customerId,
            transactionId = paymentRequest.transactionId))
    }

//    @GetMapping(value = ["/stock"])
//    fun getStock(@RequestParam itemId: String): ResponseEntity<StockResponse?> {
//        return ResponseEntity.ok(userService.getStockByItemId(itemId = itemId, email = SecurityContextHolder.getContext().authentication.name))
//    }
}