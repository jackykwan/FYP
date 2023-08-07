package com.kkm.fyp.host.models

import com.kkm.fyp.host.utils.IdUtil
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Document
data class Transaction(
    @Id
    var id: String = IdUtil.getId(),
    var transactionItems: List<TransactionItem>,
    var date: String,
    var customerId: String?,
    var shopId: String,
    var isPaid: Boolean,
    var shopName: String = ""
)