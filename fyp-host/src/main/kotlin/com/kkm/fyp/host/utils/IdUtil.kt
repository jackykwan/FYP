package com.kkm.fyp.host.utils

import java.util.UUID

class IdUtil {
    companion object {
        fun getId(): String {
            return UUID.randomUUID().toString()
        }
    }
}