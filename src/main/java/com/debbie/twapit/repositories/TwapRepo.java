package com.debbie.twapit.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.Twap;

@Repository
public interface TwapRepo extends CrudRepository<Twap, Long> {

	@Query("SELECT t.createdAt, t.user.id, t.user.name, t.content, t.user.imgUrl FROM Twap t WHERE t.lon = :lng AND t.lat = :lat")
	List<Object[]> findMarkerInfo(@Param("lat") double lat, @Param("lng") double lng);
}
