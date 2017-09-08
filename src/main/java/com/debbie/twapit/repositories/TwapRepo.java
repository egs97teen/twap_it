package com.debbie.twapit.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.Twap;

@Repository
public interface TwapRepo extends CrudRepository<Twap, Long> {
	
	@Query("SELECT t FROM Twap t ORDER BY t.createdAt DESC")
	List<Twap> getRecentTwaps();
	
}
