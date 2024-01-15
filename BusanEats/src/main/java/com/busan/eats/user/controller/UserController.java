package com.busan.eats.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;

import com.busan.eats.user.model.service.UserServiceImpl;

@Controller
public class UserController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

}
