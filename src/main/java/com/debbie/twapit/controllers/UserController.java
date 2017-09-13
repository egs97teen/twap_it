package com.debbie.twapit.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.debbie.twapit.models.Friend;
import com.debbie.twapit.models.Twap;
import com.debbie.twapit.models.User;
import com.debbie.twapit.services.TwapService;
import com.debbie.twapit.services.UserService;
import com.debbie.twapit.services.FriendService;
import com.debbie.twapit.validators.UserValidator;

@Controller
public class UserController {
	
	private UserService userService;
	private UserValidator userValidator;
	private TwapService twapService;
	private FriendService friendService;
	
	public UserController(UserService userService, UserValidator userValidator, TwapService twapService, FriendService friendService) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.twapService = twapService;
		this.friendService = friendService;
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
	public String dashboard(Principal principal, Model model, @ModelAttribute("twap") Twap twap) {
		User currentUser = userService.findByEmail(principal.getName());
		model.addAttribute("currentUser", currentUser);
		
		List<User> invitations = friendService.findInvitations(currentUser.getId());
		model.addAttribute("invitations", invitations);
		
		List<Twap> twaps = twapService.getTwaps();
		model.addAttribute("twaps", twaps);
		
		return "dashView";
	}

	@RequestMapping("/user/{user_id}")
	public String userPage(Principal principal, Model model, @PathVariable("user_id") Long user_id) {
		User currentUser = userService.findByEmail(principal.getName());
		model.addAttribute("currentUser", currentUser);
		
		List<User> invitations = friendService.findInvitations(currentUser.getId());
		model.addAttribute("invitations", invitations);
		
		User user = userService.findUserById(user_id);
		model.addAttribute("user", user);
		
		if(user == currentUser) {
			model.addAttribute("self", true);
			
			List<User> friends_list = friendService.findFriends(currentUser.getId());
			model.addAttribute("friends_list", friends_list);
			model.addAttribute("userObject", currentUser);
		} else {
			model.addAttribute("self", false);
			
			Friend invite = friendService.findInvite(user.getId(), currentUser.getId());
			if(invite != null) {
				model.addAttribute("invite", "pending");
			}
			
			Friend friendship = friendService.findFriendship(user.getId(), currentUser.getId());
			if (friendship == null) {
				model.addAttribute("friendship", "none");
			} else if (friendship.isAccept() == false) {
				model.addAttribute("friendship", "invited");
			} else if (friendship.isAccept() == true) {
				model.addAttribute("friendship", "friends");
			} 
			List<User> friends_list = friendService.findFriends(user.getId());
			model.addAttribute("friends_list", friends_list);
		}
		
		return "userView";
	}
	
	@RequestMapping("/invite/{friend_id}")
	public String addFriend(Principal principal, @PathVariable("friend_id") Long friend_id) {
		User friend = userService.findUserById(friend_id);
		User currentUser = userService.findByEmail(principal.getName());
		
		friendService.inviteFriend(friend, currentUser);
		
		return "redirect:/user/" + friend_id;
	}
	
	@RequestMapping("/accept/{friend_id}")
	public String acceptFriend(Principal principal, @PathVariable("friend_id") Long friend_id) {
		User currentUser = userService.findByEmail(principal.getName());
		User friend = userService.findUserById(friend_id);
		
		friendService.acceptFriend(friend, currentUser);
		return "redirect:/user/" + currentUser.getId();
	}
	
	@RequestMapping("/reject/{friend_id}")
	public String rejectFriend(Principal principal, @PathVariable("friend_id") Long friend_id) {
		User currentUser = userService.findByEmail(principal.getName());
		User friend = userService.findUserById(friend_id);
		
		friendService.rejectFriend(friend, currentUser);
		return "redirect:/user/" + currentUser.getId();
	}

//	Delete a user, checks to make sure currentUser is administrator, if not, does not delete user and redirects to home-page.
	@RequestMapping("/admin/delete/{user_id}")
	public String removeUser(@PathVariable("user_id") Long user_id, Principal principal, Model model) {
		User currentUser = userService.findByEmail(principal.getName());
		User targetUser = userService.findUserById(user_id);
		if(currentUser.getLevel().equals("admin")) {
			userService.removeUser(targetUser);
			return "redirect:/admin";
		}else {
			return "redirect:/reroute";
		}
		
	}
	
	@RequestMapping("/admin")
	public String adminDashboard(Principal principal, Model model) {
		User currentUser = userService.findByEmail(principal.getName());
		
		List<User> invitations = friendService.findInvitations(currentUser.getId());
		model.addAttribute("invitations", invitations);
		
		List<Twap> twaps = twapService.getTwaps();
		List<User> allUsers = userService.findAllUsers();
		model.addAttribute("twaps", twaps);
		model.addAttribute("allUsers", allUsers);
		if(currentUser.getLevel().equals("admin")) {
			model.addAttribute("currentUser", currentUser);
			return "adminDashboard";
		}else {
			return "redirect:/dashboard";
		}
	}
	
	@RequestMapping("/admin/promote/{user_id}")
	public String promoteUser(@PathVariable("user_id") Long user_id, Principal principal) {
		User currentUser = userService.findByEmail(principal.getName());
		User targetUser = userService.findUserById(user_id);
		if(currentUser.getLevel().equals("admin")) {
			userService.saveUserWithAdminRole(targetUser);
			return "redirect:/admin";
		}else {
			return "redirect:/reroute";
		}
	}	
	
	@RequestMapping("/about")
	public String aboutPage(Principal principal, Model model) {
		User currentUser = userService.findByEmail(principal.getName());
		model.addAttribute("currentUser", currentUser);
		return "aboutView";
	}

}