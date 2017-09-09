package com.debbie.twapit.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.debbie.twapit.models.User;
import com.debbie.twapit.services.TwapService;
import com.debbie.twapit.services.UserService;

@RestController	
public class SearchController {

	private static final Date[] Date = null;
	private UserService userService;
	private TwapService twapService;
	
	public SearchController(UserService userService, TwapService twapService) {
		this.userService = userService;
		this.twapService = twapService;
	}
	
	@RequestMapping("/search")
	public List<Object[]> searchUsers(@RequestParam("query") String searchQuery, Principal principal) {
		User currentUser = userService.findByEmail(principal.getName());
		
		List<Object[]> foundUsers = userService.findUsers(searchQuery, currentUser.getId());
		return foundUsers;
	}
	
	@RequestMapping("/searchMarker")
	public List<Object[]> searchForMarker(@RequestParam("lat") double lat, @RequestParam("lng") double lng) {
		List<Object[]> markerTwap = twapService.findMarkerInfo(lat, lng);
		
		return markerTwap;
	}
}
