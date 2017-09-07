package com.debbie.twapit.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.debbie.twapit.models.User;
import com.debbie.twapit.services.UserService;

@RestController	
public class SearchController {

	private UserService userService;
	
	public SearchController(UserService userService) {
		this.userService = userService;
	}
	
	@RequestMapping("/search")
	public List<Object[]> searchUsers(@RequestParam("query") String searchQuery, Principal principal) {
		User currentUser = userService.findByEmail(principal.getName());
		
		List<Object[]> foundUsers = userService.findUsers(searchQuery, currentUser.getId());
		return foundUsers;
	}
	
}
