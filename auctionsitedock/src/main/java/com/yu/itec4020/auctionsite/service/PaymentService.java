package com.yu.itec4020.auctionsite.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yu.itec4020.auctionsite.model.Item;
import com.yu.itec4020.auctionsite.model.Payment;
import com.yu.itec4020.auctionsite.repo.PaymentRepository;

@Service
public class PaymentService {
	@Autowired
    private PaymentRepository paymentRepo;
	
	public Payment findByPaymentId(int paymentId) {
        return paymentRepo.findById(paymentId);
    }

	@Transactional
	public Payment createPayment(Payment payment) {
	    Payment saved = paymentRepo.save(payment);

	    // Double-check if the Item exists before setting the Payment
	    Item item = saved.getItem();
	    if (item != null) {
	        item.setPayment(saved);
	    }

	    return saved;
	}
}
