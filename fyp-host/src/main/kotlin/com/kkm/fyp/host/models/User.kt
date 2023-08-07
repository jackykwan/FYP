package com.kkm.fyp.host.models

import com.kkm.fyp.host.utils.IdUtil
import org.jetbrains.annotations.NotNull
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Document
data class User (
    @Id
    var id: String = IdUtil.getId(),
    var stocks: List<Stock> = listOf(),
    @NotNull
    var email: String,
    @NotNull
    var password: String,
    var shopName: String?,
    var walletAmount: Number = 0,
    var transactions: List<Transaction> = listOf()
)