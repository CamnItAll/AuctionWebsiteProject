package com.yu.itec4020.auctionsite.web;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.model.enums.AuctionType;
import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.Bid;
import com.yu.itec4020.auctionsite.repo.UserRepository;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import com.yu.itec4020.auctionsite.repo.BidRepository;
import com.yu.itec4020.auctionsite.service.AuctionService;
import com.yu.itec4020.auctionsite.service.CatalogueService;

@Controller
@RequestMapping("/auction")
public class AuctionController {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
    private CatalogueService catalogueService;
	
    @Autowired
    private AuctionService auctionService;
    
    private Authentication authentication;

    @GetMapping("/{itemId}")
    public String viewAuction(@PathVariable int itemId, Model model) {
        Item item = auctionService.findByAuctionId(itemId);  // Get auction item details

        // Get the current authenticated user
        authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = userRepo.findByUsername(authentication.getName());

        // Add item and user info to the model
        model.addAttribute("item", item);
        model.addAttribute("currentUser", currentUser);

        // Add flags like canBid, canBuyNow, isOwner based on the auction item and the user
        if (item.getEndDate().isAfter(LocalDateTime.now()) && item.getAuctionStatus().equals("OPEN")) {
        	System.out.println("OK!");
	        if (item.getAuctionType().equals(AuctionType.FORWARD)) {
	        	model.addAttribute("canBid", currentUser != null && !currentUser.equals(item.getOwner()));
	        	model.addAttribute("isOwnerF", currentUser != null && currentUser.equals(item.getOwner()));
	        } else if (item.getAuctionType().equals(AuctionType.DUTCH)) {
	        	model.addAttribute("canBuyNow", currentUser != null && !currentUser.equals(item.getOwner()));
	            model.addAttribute("isOwnerD", currentUser != null && currentUser.equals(item.getOwner()));
	        }
        } else {
        	model.addAttribute("auctionEnded", currentUser != null && !currentUser.equals(item.getHighestBidder()));
        	model.addAttribute("auctionEndedBuy", currentUser != null && currentUser.equals(item.getHighestBidder()));
        }

        return "auction";  // JSP view name
    }

    @PostMapping("/placeBid/{itemId}")
    public String placeBid(@PathVariable int itemId, Model model, @RequestParam Double bidAmount) {
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	User currentUser = userRepo.findByUsername(authentication.getName());
    	Item item = auctionService.findByAuctionId(itemId);
    	if (item.getAuctionType().equals(AuctionType.FORWARD) && bidAmount > item.getCurrentPrice())
    		auctionService.placeBid(itemId, bidAmount, currentUser);
    	else {
    	}
        return "redirect:/auction/" + itemId;
    }
    
    @PostMapping("/pay/{itemId}")
    public String payForAuction(@PathVariable int itemId) {
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	User currentUser = userRepo.findByUsername(authentication.getName());
        Item item = auctionService.findByAuctionId(itemId);
    	if (item.getAuctionType().equals(AuctionType.DUTCH)) {
    		auctionService.placeBid(itemId, item.getCurrentPrice(), currentUser);
    	} else {
    	}
        //double totalAmount = item.getStartPrice() + item.getExpeditedShippingPrice();
        //auctionService.makePayment(itemId, currentUser, totalAmount);
        return "redirect:/auction/" + itemId;
    }

    @PostMapping("/updateDutchPrice/{itemId}")
    public String updateDutchAuctionPrice(@PathVariable int itemId, @RequestParam Double newPrice) {
        auctionService.updateDutchAuctionPrice(itemId, newPrice);
        return "redirect:/auction/" + itemId;
    }
}
