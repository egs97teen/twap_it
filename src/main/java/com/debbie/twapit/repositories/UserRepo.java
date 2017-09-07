package com.debbie.twapit.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {
	User findByEmail(String email);
	
	@Query("SELECT u.id, u.imgUrl, u.name, u.email FROM User u WHERE u.id != :id AND u.name LIKE CONCAT('%',:searchQuery,'%') ORDER BY u.name ASC")
	List<Object[]> findUsers(@Param("searchQuery") String searchQuery, @Param("id") Long id);
}
