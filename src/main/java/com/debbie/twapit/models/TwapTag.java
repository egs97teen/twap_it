package com.debbie.twapit.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="twaptags")
public class TwapTag {
	@Id
	@GeneratedValue
	private Long id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="twap_id")
	private Twap twap;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="tag_id")
	private Tag tag;
	
	public TwapTag() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Twap getTwap() {
		return twap;
	}

	public void setTwap(Twap twap) {
		this.twap = twap;
	}

	public Tag getTag() {
		return tag;
	}

	public void setTag(Tag tag) {
		this.tag = tag;
	}
	
	
}
