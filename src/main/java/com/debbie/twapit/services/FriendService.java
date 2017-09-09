package com.debbie.twapit.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.debbie.twapit.models.Friend;
import com.debbie.twapit.models.User;
import com.debbie.twapit.repositories.FriendRepo;

@Service
public class FriendService {
	private FriendRepo friendRepo;
	
	public FriendService(FriendRepo friendRepo) {
		this.friendRepo = friendRepo;
	}
	
	public Friend findInvite(Long friend_id, Long currentUser_id) {
		return friendRepo.findInvite(friend_id, currentUser_id);
	}
	
	public Friend findFriendship(Long friend_id, Long currentUser_id) {
		return friendRepo.findFriendship(friend_id, currentUser_id);
	}
	
	public void inviteFriend(User friend, User currentUser) {
		Friend newFriendship = new Friend();
		newFriendship.setAccept(false);
		newFriendship.setFriend(friend);
		newFriendship.setUser(currentUser);
		
		friendRepo.save(newFriendship);
	}
	
	public List<User> findInvitations(Long user_id) {
		return friendRepo.findInvitations(user_id);
	}
	
	public List<Object[]> findInvitationsForNav(Long user_id) {
		return friendRepo.findInvitationsForNav(user_id);
	}
	
	public void acceptFriend(User friend, User currentUser) {
		Friend friendship = friendRepo.findFriendship(friend, currentUser);
		friendship.setAccept(true);
		
		friendRepo.save(friendship);
		
		Friend friendship2 = new Friend();
		friendship2.setAccept(true);
		friendship2.setUser(currentUser);
		friendship2.setFriend(friend);
		
		friendRepo.save(friendship2);
	}
	
	public void rejectFriend(User friend, User currentUser) {
		Friend friendship = friendRepo.findFriendship(friend, currentUser);
		friendRepo.delete(friendship);
	}
	
	public List<User> findFriends(Long id) {
		return friendRepo.findFriends(id);
	}
}
