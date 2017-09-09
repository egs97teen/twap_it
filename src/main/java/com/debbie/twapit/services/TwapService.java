package com.debbie.twapit.services;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

import com.debbie.twapit.models.Tag;
import com.debbie.twapit.models.Twap;
import com.debbie.twapit.models.TwapTag;
import com.debbie.twapit.repositories.TagRepo;
import com.debbie.twapit.repositories.TwapRepo;
import com.debbie.twapit.repositories.TwapTagRepo;

@Service
public class TwapService {
	
	private TwapRepo twapRepo;
	private TagRepo tagRepo;
	private TwapTagRepo twapTagRepo;
	
	public TwapService(TwapRepo twapRepo, TagRepo tagRepo, TwapTagRepo twapTagRepo) {
		this.twapRepo = twapRepo;
		this.tagRepo = tagRepo;
		this.twapTagRepo = twapTagRepo;
	}
	
	public void saveTwap(Twap twap) {
		twapRepo.save(twap);
		
		String string = twap.getContent();
		Pattern pattern = Pattern.compile("#(\\w+)");
		Matcher matcher = pattern.matcher(string);
		
		while (matcher.find()) {
			TwapTag newTwapTag = new TwapTag();
			Tag tag = tagRepo.checkTag(matcher.group(1));
			
			if (tag == null) {
				Tag newTag = new Tag();
				newTag.setSubject(matcher.group(1));
				tagRepo.save(newTag);
				
				newTwapTag.setTag(newTag);
			} else {
				newTwapTag.setTag(tag);
			}
			newTwapTag.setTwap(twap);
			twapTagRepo.save(newTwapTag);
		}
	}

	public List<Twap> getTwaps() {
		return twapRepo.getRecentTwaps();
	}
	
	public List<Object[]> findMarkerInfo(double lat, double lng) {
		return (List<Object[]>) twapRepo.findMarkerInfo(lat, lng);
	}
}
