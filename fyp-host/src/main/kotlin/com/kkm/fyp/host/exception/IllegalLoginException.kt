package com.kkm.fyp.host.exception

class IllegalLoginException(message: String, cause: Throwable? = null) : ClientException(ErrorCode.ERR_LOGIN_FAILED, message, cause)