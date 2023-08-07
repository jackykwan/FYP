package com.kkm.fyp.host.exception

import java.lang.Exception

open class ClientException(val errorCode: ErrorCode, override val message: String, override val cause: Throwable?) : Exception(message, cause)