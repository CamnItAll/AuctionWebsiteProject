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
        return itemRepo.searchUnpaidByName(keyword);
    }

    public Item findByAuctionId(int itemId) {
        return itemRepo.findById(itemId);
    }

    public List<Item> findAllItems() {
        return itemRepo.findAllUnpaid();
    }

    public Item saveItem(Item item) {
        return itemRepo.save(item);
    }
}
