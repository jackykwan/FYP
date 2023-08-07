package com.kkm.fyp.host.models

import com.kkm.fyp.host.utils.IdUtil
import org.jetbrains.annotations.NotNull
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Document
data class Stock (
    var id: String,
    @NotNull
    var name: String,
    @NotNull
    var price: Number,
    var quantity: Int = 0,
)