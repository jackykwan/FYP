package com.kkm.fyp.host.exception

import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus.*
import org.springframework.http.ResponseEntity
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.core.AuthenticationException
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.client.RestClientException
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler

@ControllerAdvice
class GlobalExceptionHandler: ResponseEntityExceptionHandler() {

    companion object {
        private val LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler::class.java)
    }

    @ResponseStatus(UNAUTHORIZED)
    @ExceptionHandler(BadTokenException::class, BadCredentialsException::class)
    fun handleAuthenticationException(ex: AuthenticationException): ResponseEntity<ErrorResponse> {
        LOGGER.info(ex.message, ex)
        val errorCode = (if (ex is BadTokenException) ErrorCode.ERR_INVALID_TOKEN else ErrorCode.ERR_LOGIN_FAILED).name
        return ResponseEntity.status(UNAUTHORIZED).body(ErrorResponse(UNAUTHORIZED.value(),
            errorCode, ex::class.java.canonicalName, ex.localizedMessage))
    }

    @ResponseStatus(INTERNAL_SERVER_ERROR)
    @ExceptionHandler(IllegalArgumentException::class)
    fun handleIllegalArgumentException(ex: IllegalArgumentException): ResponseEntity<ErrorResponse> {
        LOGGER.info(ex.message, ex)
        return ResponseEntity.status(400).body(ErrorResponse(
            400,
            ErrorCode.ERR_ILLEGAL_ARGUMENT.name, ex::class.java.canonicalName, ex.localizedMessage))
    }

    @ResponseStatus(BAD_REQUEST)
    @ExceptionHandler(ClientException::class)
    fun handleBadRequest(ex: ClientException): ResponseEntity<ErrorResponse> {
        LOGGER.info(ex.message, ex)
        return ResponseEntity.badRequest().body(ErrorResponse(BAD_REQUEST.value(),
            ex.errorCode.name, ex::class.java.canonicalName, ex.localizedMessage))
    }

    @ResponseStatus(BAD_GATEWAY)
    @ExceptionHandler(ThirdPartyException::class, RestClientException::class)
    fun handleBadGatewayRequest(ex: Exception): ResponseEntity<ErrorResponse> {
        LOGGER.error(ex.message, ex)
        return ResponseEntity.status(BAD_GATEWAY).body(ErrorResponse(BAD_GATEWAY.value(),
            ErrorCode.ERR_BAD_GATEWAY.name,ex::class.java.canonicalName, ex.localizedMessage))
    }

    @ResponseStatus(INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception::class)
    fun handleUnknownError(ex: Exception): ResponseEntity<ErrorResponse> {
        LOGGER.error(ex.message, ex)
        return ResponseEntity.internalServerError().body(ErrorResponse(INTERNAL_SERVER_ERROR.value(),
            ErrorCode.ERR_UNKNOWN.name,ex::class.java.canonicalName, ex.localizedMessage))
    }
}