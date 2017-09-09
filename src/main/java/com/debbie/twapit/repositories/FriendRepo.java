package com.debbie.twapit.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.Friend;
import com.debbie.twapit.models.User;

@Repository
public interface FriendRepo extends CrudRepository<Friend, Long> {
	@Query("SELECT f FROM Friend f WHERE f.friend.id = ?1 AND f.user.id = ?2")
	Friend findFriendship(Long friend_id, Long currentUser_id);

	@Query("SELECT f.user FROM Friend f WHERE f.friend.id = ?1 AND f.accept = false")
	List<User> findInvitations(Long user_id);
	
	@Query("SELECT f FROM Friend f WHERE f.user = ?1 AND f.friend = ?2")
	Friend findFriendship(User friend, User currentUser);
	
	@Query("SELECT f FROM Friend f WHERE f.user.id = ?1 AND f.friend.id = ?2 AND f.accept = false")
	Friend findInvite(Long friend_id, Long currentUser_id);
	
	@Query("SELECT f.friend FROM Friend f WHERE f.user.id = ?1 AND f.accept = true")
	List<User> findFriends(Long id);
	
	@Query("SELECT f.user.id, f.user.name, f.user.email FROM Friend f WHERE f.friend.id = ?1 AND f.accept = false")
	List<Object[]> findInvitationsForNav(Long user_id);

}
