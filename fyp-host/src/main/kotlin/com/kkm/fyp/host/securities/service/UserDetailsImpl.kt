package com.kkm.fyp.host.securities.service
import com.kkm.fyp.host.models.User
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class UserDetailsImpl(private val user: User) : UserDetails {
    override fun getAuthorities(): Collection<GrantedAuthority> {
        return listOf()
    }

    override fun getPassword(): String? {
        return user.password
    }

    override fun getUsername(): String {
        return user.email
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun isEnabled(): Boolean {
        return true
    }
}