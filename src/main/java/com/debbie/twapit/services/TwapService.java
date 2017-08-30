package com.debbie.twapit.services;

import org.springframework.stereotype.Service;

import com.debbie.twapit.models.Twap;
import com.debbie.twapit.repositories.TwapRepo;

@Service
public class TwapService {
	
	private TwapRepo twapRepo;
	
	public TwapService(TwapRepo twapRepo) {
		this.twapRepo = twapRepo;
	}
	
	public void saveTwap(Twap twap) {
		twapRepo.save(twap);
	}

}
