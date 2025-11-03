package com.yu.itec4020.auctionsite.service;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CatalogueService {
	@Autowired
    private ItemRepository itemRepo;
	
	public List<Item> searchAuctions(String keyword) {
		if (keyword == "")
			return itemRepo.findByNameContaining("##");
		else
			return itemRepo.findByNameContaining(keyword);
    }
	
    public Item findById(int itemId) {
        return itemRepo.findById(itemId);
    }

}
