package com.kkm.fyp.host.exception

class UserNotFoundException(message: String, cause: Throwable? = null) : ClientException(ErrorCode.ERR_USER_NOT_EXIST, message, cause)