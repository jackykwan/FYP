package com.kkm.fyp.host.exception

import java.lang.Exception

class ThirdPartyException(message: String, cause: Throwable? = null) : Exception(message, cause)