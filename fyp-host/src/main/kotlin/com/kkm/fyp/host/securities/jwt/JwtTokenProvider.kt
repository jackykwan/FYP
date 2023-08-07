package com.kkm.fyp.host.securities.jwt

import com.kkm.fyp.host.configs.JwtProperties
import io.jsonwebtoken.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.time.Clock
import java.time.Duration
import java.util.*

@Component
class JwtTokenProvider(private val jwtProperties: JwtProperties) {
    companion object {
        private val LOGGER = LoggerFactory.getLogger(JwtTokenProvider::class.java)
    }

    /**
     * Retrieve username from jwt token
     */
    @Throws(
        ExpiredJwtException::class,
        UnsupportedJwtException::class,
        MalformedJwtException::class,
        SignatureException::class,
        IllegalArgumentException::class
    )
    fun getUsernameFromToken(token: String): String {
        return getAllClaimsFromToken(token).subject
    }

    /**
     * Retrieve any information from token we will need the secret key
     */
    @Throws(
        ExpiredJwtException::class,
        UnsupportedJwtException::class,
        MalformedJwtException::class,
        SignatureException::class,
        IllegalArgumentException::class
    )
    private fun getAllClaimsFromToken(token: String): Claims {
        return Jwts.parser().setSigningKey(jwtProperties.secret).parseClaimsJws(token).body
    }

    /**
     *  while creating the token -
    1. Define  claims of the token, like Issuer, Expiration, Subject, and the ID
    2. Sign the JWT using the HS512 algorithm and secret key.
    3. According to JWS Compact Serialization(https://tools.ietf.org/html/draft-ietf-jose-json-web-signature-41#section-3.1)
    compaction of the JWT to a URL-safe string
     */
    fun generateToken(username: String): String {
        val claims = HashMap<String, Any>()
        val timeout =
            Date.from(Clock.systemUTC().instant().plus(Duration.ofHours(jwtProperties.tokenTimeoutHours.toLong())))
        return Jwts.builder()
            .setClaims(claims)
            .setSubject(username)
            .setIssuedAt(Date(System.currentTimeMillis()))
            .setExpiration(
                timeout
            )
            .signWith(SignatureAlgorithm.HS512, jwtProperties.secret).compact()

    }

    /**
     * validate token
     */
    fun validateToken(token: String, testUsername: String): Boolean {
        try {
            return getUsernameFromToken(token) == testUsername
        } catch (e: SignatureException) {
            LOGGER.error("Invalid JWT signature: {}", e.message)
        } catch (e: MalformedJwtException) {
            LOGGER.error("Invalid JWT token: {}", e.message)
        } catch (e: ExpiredJwtException) {
            LOGGER.error("JWT token is expired: {}", e.message)
        } catch (e: UnsupportedJwtException) {
            LOGGER.error("JWT token is unsupported: {}", e.message)
        } catch (e: IllegalArgumentException) {
            LOGGER.error("JWT claims string is empty: {}", e.message)
        }
        return false
    }
}
