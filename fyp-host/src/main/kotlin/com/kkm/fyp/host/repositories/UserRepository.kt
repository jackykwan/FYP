package com.kkm.fyp.host.repositories

import com.kkm.fyp.host.models.Item
import com.kkm.fyp.host.models.User
import org.springframework.data.mongodb.repository.MongoRepository

interface UserRepository : MongoRepository<User?, String?> {
    fun findUserByEmail(email: String) : User?

    fun findUserById(id: String): User?
}