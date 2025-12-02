package com.yu.itec4020.auctionsite.service;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.enums.AuctionType;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CatalogueService {
    @Autowired
    private ItemRepository itemRepo;

    public List<Item> searchAuctions(String keyword) {
    	List<Item> items = itemRepo.searchUnpaidByName(keyword);

        for (Item item : items) { // Close expired forward auctions that got no bids
            if (item.getAuctionType().equals(AuctionType.FORWARD)
                    && item.getEndDate().isBefore(java.time.LocalDateTime.now())
                    && item.getHighestBidder() == null
                    && item.getAuctionStatus().equals("OPEN")) {
                item.setAuctionStatus("CLOSED");
                itemRepo.save(item);
            }
        }
        return items.stream() // Only return items that are OPEN, or CLOSED but have a winning bidder
                .filter(i -> "OPEN".equals(i.getAuctionStatus()) ||
                            ("CLOSED".equals(i.getAuctionStatus()) && i.getHighestBidder() != null))
                .toList();
    }

    public Item findByAuctionId(int itemId) {
        return itemRepo.findById(itemId);
    }

    public List<Item> findAllItems() {
        List<Item> items = itemRepo.findAllUnpaid();

        // Same as searchAuctions()
        for (Item item : items) {
            if (item.getAuctionType().equals(AuctionType.FORWARD)
                    && item.getEndDate().isBefore(java.time.LocalDateTime.now())
                    && item.getHighestBidder() == null
                    && item.getAuctionStatus().equals("OPEN")) {
                item.setAuctionStatus("CLOSED");
                itemRepo.save(item);
            }
        }
        return items.stream()
                .filter(i -> "OPEN".equals(i.getAuctionStatus()) ||
                            ("CLOSED".equals(i.getAuctionStatus()) && i.getHighestBidder() != null))
                .toList();
    }

    public Item saveItem(Item item) {
        return itemRepo.save(item);
    }
}
