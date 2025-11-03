package com.yu.itec4020.auctionsite.service;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.model.enums.AuctionType;
import com.yu.itec4020.auctionsite.model.Bid;
import com.yu.itec4020.auctionsite.model.Payment;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import com.yu.itec4020.auctionsite.repo.BidRepository;
import com.yu.itec4020.auctionsite.repo.PaymentRepository;

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
	
	public Bid placeBid(int itemId, Double bidAmount, User user) throws IllegalArgumentException{
        Item auction = findByAuctionId(itemId);
        Bid bid = new Bid();
        bid.setAmount(bidAmount);
        bid.setItem(auction);
        bid.setUser(user);

        auction.setCurrentPrice(bidAmount); // Update auction's current price
        auction.setHighestBidder(user); // Set highest bidder
        
        if (auction.getAuctionType().equals(AuctionType.DUTCH))
        	auction.setStatus("CLOSED");

        itemRepo.save(auction); // Save auction state
        return bidRepo.save(bid); // Save the bid
        }
	
	public void updateDutchAuctionPrice(int itemId, Double newPrice) {
        Item item = findByAuctionId(itemId);
        if (item.getAuctionType().equals(AuctionType.DUTCH)) {
            item.setCurrentPrice(newPrice);
            itemRepo.save(item);
        }
    }

}
