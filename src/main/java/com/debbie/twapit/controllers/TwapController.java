package com.debbie.twapit.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.debbie.twapit.models.Twap;
import com.debbie.twapit.models.User;
import com.debbie.twapit.services.TwapService;
import com.debbie.twapit.services.UserService;

@Controller
public class TwapController {
	
	private UserService userService;
	private TwapService twapService;
	
	public TwapController(UserService userService, TwapService twapService) {
		this.userService = userService;
		this.twapService = twapService;
	}
	
	@PostMapping("/dashboard")
	public String addContent(Principal principal, @ModelAttribute("twap") Twap twap) {
		User currentUser = userService.findByEmail(principal.getName());
		twap.setUser(currentUser);
		twapService.saveTwap(twap);
		return "redirect:/dashboard";
	}
	
	@RequestMapping("/delete/{twap_id}")
	public String deleteContent(@PathVariable("twap_id") Long twap_id, Principal principal) {
		User currentUser = userService.findByEmail(principal.getName());
		Twap targetTwap = twapService.getTwapById(twap_id);
		if(currentUser.getLevel().equals("admin")) {
			twapService.deleteTwap(targetTwap);
			return "redirect:/admin";
		}else if(currentUser == targetTwap.getUser()) {
			twapService.deleteTwap(targetTwap);
			return "redirect:/user/"+currentUser.getId();
		}else {
			return "redirect:/reroute";
		}
	}
	
}
