package com.yu.itec4020.auctionsite.web;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.repo.UserRepository;
import com.yu.itec4020.auctionsite.service.AuctionService;
import com.yu.itec4020.auctionsite.service.CatalogueService;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/catalogue")
public class CatalogueController {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
    private CatalogueService catalogueService;
	
	@Autowired
    private AuctionService auctionService;
	
	// 1️⃣ When visiting /catalogue/ (no keyword)
    @GetMapping("/")
    public String viewAllItems(Model model) {
        List<Item> items = catalogueService.findAllItems();
        model.addAttribute("items", items);
        return "catalogue";
    }

    // 2️⃣ When visiting /catalogue/?keyword=...
    @GetMapping(params = "keyword")
    public String searchItems(@RequestParam("keyword") String keyword, Model model) {
        List<Item> items = catalogueService.searchAuctions(keyword);
        model.addAttribute("items", items);
        return "catalogue";
    }
	
	@GetMapping("/new")
    public String showNewAuctionForm(Model model) {
        model.addAttribute("itemForm", new Item());
        return "newitem";
    }
	
    @PostMapping("/create")
    public String createNewAuction(@ModelAttribute("itemForm") Item item, @RequestParam String endDate, Principal principal) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        String username = principal.getName();
        User currentUser = userRepo.findByUsername(username);

        item.setOwner(currentUser);
        item.setCurrentPrice(item.getStartPrice());
        item.setEndDate(LocalDateTime.parse(endDate, formatter));  // Convert endDate string to LocalDateTime
        auctionService.saveItem(item);
        return "redirect:/catalogue";
    }

}
