package com.kkm.fyp.host.exception

class UserAlreadyRegisteredException(message: String, cause: Throwable? = null) : ClientException(ErrorCode.ERR_SIGNUP_DUPLICATE, message, cause)