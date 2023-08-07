package com.kkm.fyp.host.configs

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.stereotype.Component
import kotlin.properties.Delegates
@Component
@ConfigurationProperties("jwt")
class JwtProperties {
    lateinit var secret: String
    lateinit var tokenHeader: String
    lateinit var tokenHead: String
    var tokenTimeoutHours by Delegates.notNull<Int>()
}