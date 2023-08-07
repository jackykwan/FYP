package com.kkm.fyp.host.dtos

import com.kkm.fyp.host.models.Stock
import com.kkm.fyp.host.models.Transaction

data class UserInfo(var email: String,
                    var stocks: List<Stock> = listOf(),
                    var shopName: String? = null,
                    var transactions: List<Transaction> = listOf(),
                    var id: String,
                    var walletAmount: Number = 0,
                    var token: String? = null)