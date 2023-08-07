package com.kkm.fyp.host.exception

class IllegalPasswordException(errorCode: ErrorCode, message: String, cause: Throwable? = null) : ClientException(errorCode, message, cause)