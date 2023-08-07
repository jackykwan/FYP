package com.kkm.fyp.host.controllers

import com.kkm.fyp.host.models.User
import com.kkm.fyp.host.repositories.UserRepository
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin
@RequestMapping(value = ["/api/v1/"])
class StockController(private val userRepository: UserRepository) {

    @GetMapping(value = [""])
    fun getAllStocks(): String {
        val user = User(email = "email", password = "password", shopName = "shopName")
        userRepository.save(user)
        return "Hello"
    }




}