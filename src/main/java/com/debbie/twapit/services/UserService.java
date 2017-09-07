package com.debbie.twapit.services;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.debbie.twapit.models.User;
import com.debbie.twapit.repositories.RoleRepo;
import com.debbie.twapit.repositories.UserRepo;

@Transactional
@Service
public class UserService {
	private UserRepo userRepo;
	private RoleRepo roleRepo;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public UserService(UserRepo userRepo, RoleRepo roleRepo, BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.userRepo = userRepo;
		this.roleRepo = roleRepo;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	public void saveUserWithRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepo.findByName("ROLE_USER"));
		user.setLevel("user");
		userRepo.save(user);
	}
	
	public void saveUserWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepo.findAll());
		user.setLevel("admin");
		userRepo.save(user);
	}
	
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	public List<User> findAllUsers() {
		return (List<User>) userRepo.findAll();
	}
	
	public User findUserById(Long id) {
		return userRepo.findOne(id);
	}
	
	public List<Object[]> findUsers(String searchQuery, Long id) {
		return userRepo.findUsers(searchQuery, id);
	}
	
}
