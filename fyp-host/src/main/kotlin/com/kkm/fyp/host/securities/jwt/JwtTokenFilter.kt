package com.kkm.fyp.host.securities.jwt

import com.kkm.fyp.host.configs.JwtProperties
import com.kkm.fyp.host.exception.BadTokenException
import com.kkm.fyp.host.securities.service.UserDetailsServiceImpl
import org.slf4j.LoggerFactory
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter
import java.io.IOException
import javax.servlet.FilterChain
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JwtTokenFilter(private val jwtProperties: JwtProperties,
                     private val userDetailsService: UserDetailsServiceImpl,
                     private val jwtTokenProvider: JwtTokenProvider
                     ): OncePerRequestFilter() {

    @Throws(ServletException::class, IOException::class)
    override fun doFilterInternal(request: HttpServletRequest, response: HttpServletResponse, chain: FilterChain) {
        val requestTokenHeader = request.getHeader(jwtProperties.tokenHeader)
        // Once we get the token validate it.
        if (requestTokenHeader != null
            && requestTokenHeader.startsWith(jwtProperties.tokenHead)
            && SecurityContextHolder.getContext().authentication == null) {
            val jwtToken = requestTokenHeader.substring(jwtProperties.tokenHead.length).trim()
            val username = try {
                jwtTokenProvider.getUsernameFromToken(jwtToken)
            } catch (ex: Exception) {
                throw BadTokenException("Invalid token")
            }
            // if token is valid configure Spring Security to manually set authentication
            if(!jwtTokenProvider.validateToken(jwtToken, username)) {
                throw BadTokenException("Invalid token")
            }
            val userDetails = userDetailsService.loadUserByUsername(username)
            val usernamePasswordAuthenticationToken = UsernamePasswordAuthenticationToken(userDetails, null, userDetails.authorities)
            usernamePasswordAuthenticationToken.details = WebAuthenticationDetailsSource().buildDetails(request)
            // After setting the Authentication in the context, we specify
            // that the current user is authenticated. So it passes the
            // Spring Security Configurations successfully.
            LOGGER.info("Authenticated user: $username")
            SecurityContextHolder.getContext().authentication = usernamePasswordAuthenticationToken
        }
        chain.doFilter(request, response)
    }

    companion object {
        private val LOGGER = LoggerFactory.getLogger(JwtTokenFilter::class.java)
    }
}
