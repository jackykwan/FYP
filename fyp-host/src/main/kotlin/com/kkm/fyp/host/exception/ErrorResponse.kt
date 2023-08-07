package com.kkm.fyp.host.exception

data class ErrorResponse (val status: Int,
                          val errorCode: String,
                          val type: String,
                          val message: String?)