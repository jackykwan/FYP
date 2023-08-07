package com.kkm.fyp.host.securities.service

import com.kkm.fyp.host.repositories.UserRepository
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service

@Service
class UserDetailsServiceImpl(private val userRepository: UserRepository) : UserDetailsService  {
    @Throws(UsernameNotFoundException::class)
    override fun loadUserByUsername(username: String): UserDetails {
        val user = userRepository.findUserByEmail(username)
        if (user != null) {
            return UserDetailsImpl(user)
        }
        throw UsernameNotFoundException("Invalid username or password")
    }
}
