package com.debbie.twapit.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.debbie.twapit.models.Twap;

@Repository
public interface TwapRepo extends CrudRepository<Twap, Long> {

}
