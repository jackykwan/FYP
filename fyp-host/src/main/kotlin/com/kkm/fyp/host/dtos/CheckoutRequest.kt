package com.kkm.fyp.host.dtos

import com.kkm.fyp.host.models.Stock
import com.kkm.fyp.host.models.TransactionItem

data class CheckoutRequest(
    val transactionItems: List<TransactionItem>,
    val transactionId: String
)