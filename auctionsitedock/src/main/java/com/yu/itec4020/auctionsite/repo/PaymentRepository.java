package com.yu.itec4020.auctionsite.repo;

import com.yu.itec4020.auctionsite.model.Payment;
import com.yu.itec4020.auctionsite.model.User;

import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByBuyer(User buyer);
    
    Payment findById(int paymentId);
}
