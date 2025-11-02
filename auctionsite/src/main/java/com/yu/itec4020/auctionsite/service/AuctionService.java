package com.yu.itec4020.auctionsite.service;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.model.Bid;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import com.yu.itec4020.auctionsite.repo.BidRepository;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuctionService {
	@Autowired
    private ItemRepository itemRepo;
	@Autowired
    private BidRepository bidRepo;
	
	public Item findByAuctionId(int itemId) {
        return itemRepo.findById(itemId);
    }
	
	public Item saveItem (Item item) {
        return itemRepo.save(item);
    }
	
	public Bid placeBid(int itemId, Double bidAmount, User user) {
        Item auction = findByAuctionId(itemId);
        if ("forward".equals(auction.getAuctionType()) && bidAmount > auction.getCurrentPrice()) {
            Bid bid = new Bid();
            bid.setAmount(bidAmount);
            bid.setItem(auction);
            bid.setUser(user);

            auction.setCurrentPrice(bidAmount); // Update auction's current price
            auction.setHighestBidder(user); // Set highest bidder

            itemRepo.save(auction); // Save auction state
            return bidRepo.save(bid); // Save the bid
        }
        throw new IllegalArgumentException("Your bid should be higher than the current price...");
    }
	
	public void updateDutchAuctionPrice(int itemId, Double newPrice) {
        Item item = findByAuctionId(itemId);
        if ("dutch".equals(item.getAuctionType())) {
            item.setStartPrice(newPrice);
            itemRepo.save(item);
        }
    }

}
