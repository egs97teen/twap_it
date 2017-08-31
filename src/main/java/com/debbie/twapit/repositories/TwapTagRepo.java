package com.debbie.twapit.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.TwapTag;

@Repository
public interface TwapTagRepo extends CrudRepository<TwapTag, Long>{

}
