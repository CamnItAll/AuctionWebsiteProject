package com.yu.itec4020.auctionsite.web;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.model.enums.AuctionType;
import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.repo.UserRepository;
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
    public String placeBid(@PathVariable int itemId,
                           @RequestParam Double bidAmount,
                           RedirectAttributes redirectAttributes) {
        authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = userRepo.findByUsername(authentication.getName());
        Item item = auctionService.findByAuctionId(itemId);

        if (item.getAuctionType().equals(AuctionType.FORWARD) && bidAmount > item.getCurrentPrice()) {
            auctionService.placeBid(itemId, bidAmount, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Your bid was placed successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Your bid must be higher than the current price.");
        }

        return "redirect:/auction/" + itemId;
    }

    @PostMapping("/pay/{itemId}")
    public String payForAuction(@PathVariable int itemId, RedirectAttributes redirectAttributes) {
        authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = userRepo.findByUsername(authentication.getName());
        Item item = auctionService.findByAuctionId(itemId);

        if (item.getAuctionType().equals(AuctionType.DUTCH)) {
            auctionService.placeBid(itemId, item.getCurrentPrice(), currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Purchase successful! Be sure to pay up soon.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Payment is only valid for Dutch auctions.");
        }

        return "redirect:/auction/" + itemId;
    }

    @PostMapping("/updateDutchPrice/{itemId}")
    public String updateDutchAuctionPrice(@PathVariable int itemId,
                                          @RequestParam Double newPrice,
                                          RedirectAttributes redirectAttributes) {
        Item item = auctionService.findByAuctionId(itemId);

        if (newPrice < item.getCurrentPrice()) {
            auctionService.updateDutchAuctionPrice(itemId, newPrice);
            redirectAttributes.addFlashAttribute("successMessage", "Price updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Your new price must be lower than the current price.");
        }

        return "redirect:/auction/" + itemId;
    }
}
