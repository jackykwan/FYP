package com.kkm.fyp.host

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration

@SpringBootApplication()
@ComponentScan(basePackages = [ "com.kkm.fyp.host.**"] )
@Configuration
class HostApplication
fun main(args: Array<String>) {
	runApplication<HostApplication>(*args)
}
