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
import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.Bid;
import com.yu.itec4020.auctionsite.repo.UserRepository;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import com.yu.itec4020.auctionsite.repo.BidRepository;
import com.yu.itec4020.auctionsite.service.AuctionService;
import com.yu.itec4020.auctionsite.service.CatalogueService;

@Controller
public class AuctionController {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
    private CatalogueService catalogueService;
	
    @Autowired
    private AuctionService auctionService;

    @GetMapping("/auction/{id}")
    public String viewAuction(@PathVariable int id, Model model) {
        Item item = auctionService.findByAuctionId(id);  // Get auction item details

        // Get the current authenticated user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = (authentication != null && authentication.getPrincipal() instanceof User) 
                             ? (User) authentication.getPrincipal()
                             : null;

        // Add item and user info to the model
        model.addAttribute("item", item);
        model.addAttribute("currentUser", currentUser);

        // Add flags like canBid, canBuyNow, isOwner based on the auction item and the user
        model.addAttribute("canBid", canPlaceBid(currentUser, item));
        model.addAttribute("canBuyNow", canBuyNow(currentUser, item));
        model.addAttribute("isOwner", currentUser != null && currentUser.equals(item.getOwner()));

        return "auction";  // JSP view name
    }

    private boolean canPlaceBid(User user, Item item) {
        // Example logic: User can place a bid if they're not the owner and the auction is still open
        return user != null && !user.equals(item.getOwner()) && item.getEndDate().isAfter(LocalDateTime.now());
    }

    private boolean canBuyNow(User user, Item item) {
        // Example logic: User can buy now if the auction type is "forward"
        return user != null && item.getAuctionType().equals("forward");
    }

    @PostMapping("/auction/placeBid/{itemId}")
    public String placeBid(@PathVariable int itemId, @RequestParam Double bidAmount, Principal principal) {
        User user = (User) principal;
        auctionService.placeBid(itemId, bidAmount, user);
        return "redirect:/auction/" + itemId;
    }

    @PostMapping("/auction/updateDutchPrice/{itemId}")
    public String updateDutchAuctionPrice(@PathVariable int itemId, @RequestParam Double newPrice) {
        auctionService.updateDutchAuctionPrice(itemId, newPrice);
        return "redirect:/auction/" + itemId;
    }
}
