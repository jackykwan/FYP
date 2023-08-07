package com.kkm.fyp.host.utils

import com.kkm.fyp.host.dtos.UserInfo
import com.kkm.fyp.host.models.User

fun User.from(userInfo: UserInfo): User {
    this.email = userInfo.email
    this.stocks = userInfo.stocks
    this.shopName = userInfo.shopName
    this.transactions = userInfo.transactions
    this.id = userInfo.id
    this.walletAmount = userInfo.walletAmount
    return this
}

fun UserInfo.from(user: User): UserInfo {
    this.email = user.email
    this.stocks = user.stocks
    this.shopName = user.shopName
    this.transactions = user.transactions
    this.id = user.id
    this.walletAmount = user.walletAmount
    return this
}