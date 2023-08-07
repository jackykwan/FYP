package com.kkm.fyp.host.models

import com.kkm.fyp.host.utils.IdUtil
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Document
data class Customer(
    @Id
    var id: String = IdUtil.getId(),
    var password: String,
    var email: String,
    var telephone: String,
    var name: String
)