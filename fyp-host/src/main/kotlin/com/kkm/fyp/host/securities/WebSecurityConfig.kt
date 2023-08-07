package com.kkm.fyp.host.securities

import com.kkm.fyp.host.securities.jwt.JwtTokenFilter
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.dao.DaoAuthenticationProvider
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.builders.WebSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true, jsr250Enabled = true)
class WebSecurityConfig(private val restfulAuthenticationEntryPoint: RestfulAuthenticationEntryPoint,
                        private val restfulAccessDeniedHandler: RestfulAccessDeniedHandler,
                        private val userDetailsService: UserDetailsService,
                        private val jwtTokenFilter: JwtTokenFilter
) {

    companion object {
        private val SKIPPED_REQUEST = listOf("/**/users/register", "/**/users/login", "/**/users")
    }

    @Bean
    fun passwordEncoder(): PasswordEncoder {
        return BCryptPasswordEncoder()
    }

    @Bean
    fun authenticationProvider(): DaoAuthenticationProvider {
        return DaoAuthenticationProvider().also {
            it.setPasswordEncoder(passwordEncoder())
            it.setUserDetailsService(userDetailsService)
        }
    }

    @Bean
    @Throws(Exception::class)
    fun authenticationManager(authenticationConfiguration: AuthenticationConfiguration): AuthenticationManager {
        return authenticationConfiguration.authenticationManager
    }

    @Bean
    @Throws(java.lang.Exception::class)
    fun filterChain(httpSecurity: HttpSecurity): SecurityFilterChain {
        httpSecurity.csrf()
            .disable() // csrf is not needed as we're using jwt
            .sessionManagement() //we use token instead of session
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS) // make sure we use stateless session; session won't be used to  store user's state.
            .and()
            .authorizeRequests()
            .antMatchers(*SKIPPED_REQUEST.toTypedArray()).permitAll() // allow anonymous access
            .anyRequest().authenticated() // all other requests need to be authenticated
        httpSecurity.headers().frameOptions().disable()
        httpSecurity.exceptionHandling()
            .accessDeniedHandler(restfulAccessDeniedHandler)
            .authenticationEntryPoint(restfulAuthenticationEntryPoint)

        // Add a filter to validate the tokens with every request
        httpSecurity.addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter::class.java)
        return httpSecurity.build()
    }

    @Bean
    fun webSecurityCustomizer(): WebSecurityCustomizer {
        return WebSecurityCustomizer { web: WebSecurity ->
            web.ignoring().antMatchers( "/css/**", "/js/**", "/img/**", "/lib/**", "/favicon.ico")
        }
    }
}
