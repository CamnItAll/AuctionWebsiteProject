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
import org.springframework.web.bind.annotation.RequestParam;
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
            return "redirect:/catalogue";
        }
        double price = item.getCurrentPrice();
        if (Double.isNaN(price) || price <= 0.0) {
            ra.addFlashAttribute("error", "Final price not set.");
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
            ra.addFlashAttribute("errorMessage", "Item not found.");
            return "redirect:/auction/" + itemId;
        }

        Long currentUserId = getCurrentUserIdOrNull();
        if (item.getHighestBidder() == null || item.getHighestBidder().getId() == null || item.getHighestBidder().getId().equals(currentUserId)) {
        	ra.addFlashAttribute("errorMessage", "Only the winner can pay for this item.");
            System.out.println(!item.getHighestBidder().getId().equals(currentUserId));
            System.out.println("Screwed up at 4");
            return "redirect:/auction/" + itemId;
        }
        
        model.addAttribute("item", item);
        model.addAttribute("payment", payment);
        
        // simple form check
        if (isBlank(payment.getCardName())    ||
            isBlank(payment.getCardNum())     ||
            isBlank(payment.getExpireDate())  ||
            isBlank(payment.getCvv())) {

            model.addAttribute("formError", "Please fill all card fields.");
            return "payment";
        }
        
        if (!payment.getCardNum().matches("^[0-9 ]*$") || !payment.getExpireDate().matches("^[0-9/]+$") || !payment.getCvv().matches("[0-9 ]+")) {
        	ra.addFlashAttribute("error", "Card number, expiredate and/or CVV shouldn't include characters or symbols.");
        	return "redirect:/payment/" + itemId + "/pay";
        } else {
	        String username = principal.getName();
	        User currentUser = userRepo.findByUsername(username);
	        payment.setBuyer(currentUser);
	        payment.setItem(item);
	        if (payment.isExpedited())
	        	payment.setAmount(item.getCurrentPrice() + item.getShippingPrice() + item.getExpeditedShippingPrice());
	        else
	        	payment.setAmount(item.getCurrentPrice() + item.getShippingPrice());
	        
	        paymentService.createPayment(payment);
	        return "redirect:/payment/" + itemId + "/receipt?paymentId=" + payment.getPaymentId();
        }
    }
   
    @GetMapping("/{itemId}/receipt")
    public String showReceipt(@PathVariable("itemId") int itemId, @RequestParam("paymentId") Long paymentId,
    							Model model, RedirectAttributes ra, Principal principal) {
        Item item = itemRepo.findById(itemId);
        if (item == null) {
            ra.addFlashAttribute("error", "Item not found.");
            return "redirect:/payment";
        }
        Payment payment = paymentService.findByPaymentId(paymentId.intValue());
        if (payment == null) {
            ra.addFlashAttribute("error", "Payment not found.");
            return "redirect:/payment";
        }
        String username = principal.getName();
        User currentUser = userRepo.findByUsername(username);
        model.addAttribute("user", currentUser);
        model.addAttribute("item", item);
        model.addAttribute("payment", payment);

        return "receipt";
    }

    // --- helpers ---
    private Long getCurrentUserIdOrNull() { return 1L; } 
    private boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
}
