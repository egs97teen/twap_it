package com.debbie.twapit.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {
	User findByEmail(String email);
	
}
