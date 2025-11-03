package com.yu.itec4020.auctionsite.web;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.Payment;
import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.repo.ItemRepository;
import com.yu.itec4020.auctionsite.repo.UserRepository;
import com.yu.itec4020.auctionsite.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	@Autowired
    private UserRepository userRepo;
	@Autowired
    private ItemRepository itemRepo;
	@Autowired
    private PaymentService paymentService;
    
    @GetMapping("/{itemId}/pay")
    public String showPay(@PathVariable("itemId") int itemId, Model model, RedirectAttributes ra) {
        Item item = itemRepo.findById(itemId);
        if (item == null) {
            ra.addFlashAttribute("error", "Item not found.");
            System.out.println("Screwed up at 1");
            return "redirect:/catalogue";
        }
        double price = item.getCurrentPrice();
        if (Double.isNaN(price) || price <= 0.0) {
            ra.addFlashAttribute("error", "Final price not set.");
            System.out.println("Screwed up at 2");
            return "redirect:/catalogue";
        }
        model.addAttribute("item", item);
        model.addAttribute("paymentForm", new Payment());
        return "payment"; // /WEB-INF/views/payment.jsp
    }

    // Handle submit
    @PostMapping("/{itemId}/pay")
    public String submitPay(@ModelAttribute("paymentForm") Payment payment, @PathVariable("itemId") int itemId, RedirectAttributes ra, Model model, Principal principal) {
        Item item = itemRepo.findById(itemId);
        if (item == null) {
            ra.addFlashAttribute("error", "Item not found.");
            System.out.println("Screwed up at 3");
            return "redirect:/catalogue";
        }

        //Long currentUserId = getCurrentUserIdOrNull();
        if (item.getHighestBidder() == null || item.getHighestBidder().getId() == null) {
            ra.addFlashAttribute("error", "Only the winner can pay for this item.");
            System.out.println("Screwed up at 4");
            return "redirect:/catalogue";
        }

        // simple form check
        if (isBlank(payment.getCardName())    ||
            isBlank(payment.getCardNum())     ||
            isBlank(payment.getExpireDate())  ||
            isBlank(payment.getCvv())) {

            model.addAttribute("item", item);
            model.addAttribute("payment", payment);
            model.addAttribute("formError", "Please fill all card fields.");
            return "payment";
        }

        String username = principal.getName();
        User currentUser = userRepo.findByUsername(username);
        
        payment.setBuyer(currentUser);
        payment.setItem(item);
        payment.setAmount(item.getCurrentPrice());
        paymentService.createPayment(payment);

        ra.addFlashAttribute("paymentId", payment.getPaymentId());
        return "redirect:/payment/" + itemId + "/receipt";
    }

   
    @GetMapping("/{itemId}/receipt")
    public String showReceipt(@PathVariable("itemId") int itemId, Model model, RedirectAttributes ra) {
        Item item = itemRepo.findById(itemId);
        if (item == null) {
            ra.addFlashAttribute("error", "Item not found.");
            System.out.println("Screwed up at 5");
            return "redirect:/catalogue";
        }

        int finalPriceCents      = dollarsToCents(item.getCurrentPrice());
        int regularShippingCents = 0;
        int expeditedCents       = dollarsToCents(item.getExpeditedShippingPrice());

        model.addAttribute("item", item);
      
        return "receipt"; 
    }

    // --- helpers ---
    private Long getCurrentUserIdOrNull() { return 1L; } 
    private boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
    private int dollarsToCents(double dollars) {
        return (int) Math.round(dollars * 100.0);
    }
}
