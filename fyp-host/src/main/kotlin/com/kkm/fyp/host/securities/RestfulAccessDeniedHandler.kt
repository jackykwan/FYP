package com.kkm.fyp.host.securities

import org.springframework.security.access.AccessDeniedException
import org.springframework.security.web.access.AccessDeniedHandler
import org.springframework.stereotype.Component
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class RestfulAccessDeniedHandler: AccessDeniedHandler {
    override fun handle(
        request: HttpServletRequest,
        response: HttpServletResponse,
        accessDeniedException: AccessDeniedException){
        response.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedException.message)
    }
}