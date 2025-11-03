package com.yu.itec4020.auctionsite.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bids")
public class Bid {
	
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Column(nullable = false)
    private Double amount;
    
    @Column(name = "bid_date", nullable = false)
    private LocalDateTime bidDate = LocalDateTime.now();
    
    // ---------- Getters and Setters ----------
    public Integer getBidId() { return id; }
    public void setBidId(Integer id) { this.id = id; }
    
    public Item getItem() { return item; }
    public void setItem(Item item) { this.item = item; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    
    public LocalDateTime getBidDate() { return bidDate; }
    public void setBidDate(LocalDateTime bidDate) { this.bidDate = bidDate; }
    
}
