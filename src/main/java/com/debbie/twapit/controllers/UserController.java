package com.debbie.twapit.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.debbie.twapit.models.User;
import com.debbie.twapit.services.UserService;
import com.debbie.twapit.validators.UserValidator;

@Controller
public class UserController {
	private UserService userService;
	private UserValidator userValidator;
	
	public UserController(UserService userService, UserValidator userValidator) {
		this.userService = userService;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("/login")
	public String loginreg(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, @ModelAttribute("userObject") User user) {
		if(error != null) {
			model.addAttribute("errorMessage", "Invalid Credentials, please try again.");
		}
		if(logout != null) {
			model.addAttribute("logoutMessage", "Logout Successful!");
		}
		return "loginView";
	}
	
	@RequestMapping("/register")
	public String register(@ModelAttribute("userObject") User user) {
		return "regView";
	}
	
	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("userObject") User user, BindingResult result) {
		userValidator.validate(user, result);
		
		if(result.hasErrors()) {
			return "regView";
		} else {
			userService.saveUserWithRole(user);
			return "redirect:/login";
		}
	}
	
	@RequestMapping(value= {"/", "/reroute"})
	public String profilePage(Principal principal) {
		User currentUser = userService.findByEmail(principal.getName());
		
		if ((currentUser.getLevel()).equals("admin")) {
			return "redirect:/dashboard";
		} else if ((currentUser.getLevel()).equals("user")) {
			return "redirect:/dashboard";
		} else {
			return "redirect:/landing";
		}
	}
	
	@RequestMapping("/dashboard")
	public String dashboard(Principal principal, Model model) {
		User currentUser = userService.findByEmail(principal.getName());
		model.addAttribute("currentUser", currentUser);
		
		return "dashView";
	}
}