package com.kkm.fyp.host.exception

import org.springframework.security.core.AuthenticationException

class BadTokenException(message: String, cause: Throwable? = null) : AuthenticationException(message, cause)