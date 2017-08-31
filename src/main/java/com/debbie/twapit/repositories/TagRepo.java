package com.debbie.twapit.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.Tag;

@Repository
public interface TagRepo extends CrudRepository<Tag, Long>{

	@Query("SELECT t FROM Tag t WHERE t.subject = ?1")
	Tag checkTag(String tag);
}
