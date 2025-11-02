package com.yu.itec4020.auctionsite.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

import com.yu.itec4020.auctionsite.model.enums.AuctionStatus;

@Entity
@Table(name = "items")
public class Item {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
	
	@Column(nullable = false)
    private String name;
	
	@Column(nullable = false)
    private String description;
	
	@Column(name = "start_price", nullable = false)
    private Double startPrice;
	
	@Column(name = "current_price",nullable = false)
    private Double currentPrice;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "auction_status", nullable = false)
	private AuctionStatus auctionStatus;
	
	@Column(name = "start_date", nullable = false)
	private LocalDateTime startDate = LocalDateTime.now();
	
	@Column(name = "end_date", nullable = false)
	private LocalDateTime endDate;
	
	@Column(name = "auction_type", nullable = false)
	private String auctionType; // "forward" or "dutch"
	
	@Column(name = "expedited_shipping_price", nullable = false)
    private Double expeditedShippingPrice;
    
	@Column(name = "shipping_days", nullable = false)
    private Integer shippingDays; // Shipping duration in days
	
	@ManyToOne
    @JoinColumn(name = "owner_id", nullable = false)
    private User owner; // Auction creator

    @ManyToOne
    @JoinColumn(name = "highest_bidder_id", nullable = true)
    private User highestBidder; // Highest bidder in a forward auction
    
    public Item() { // Ensure that auctionStatus is set to a valid default value
        this.auctionStatus = AuctionStatus.OPEN;
    }
	
	// ---------- Getters and Setters ----------
    public int getItemId() { return id; }
    public void setItemId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public double getStartPrice() { return startPrice; }
    public void setStartPrice(double startPrice) { this.startPrice = startPrice; }
    
    public double getCurrentPrice() { return currentPrice; }
    public void setCurrentPrice(double currentPrice) { this.currentPrice = currentPrice; }
    
    public String getStatus() { return auctionStatus.name(); }
    public void setStatus(String auctionStatus) { this.auctionStatus = AuctionStatus.valueOf(auctionStatus); }
    
    public LocalDateTime getStartDate() { return startDate; }
    
    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }
    
    public String getAuctionType() { return auctionType; }
    public void setAuctionType(String auctionType) { this.auctionType = auctionType; }
    
    public double getExpeditedShippingPrice() { return expeditedShippingPrice; }
    public void setExpeditedShippingPrice(double expeditedShippingPrice) { this.expeditedShippingPrice = expeditedShippingPrice; }
    
    public Integer getShippingDays() { return shippingDays; }
    public void setShippingDays(Integer shippingDays) { this.shippingDays = shippingDays; }
    
    public User getOwner() { return owner; }
    public void setOwner(User owner) { this.owner = owner; }
    
    public User getHighestBidder() { return highestBidder; }
    public void setHighestBidder(User highestBidder) { this.highestBidder = highestBidder; }
}
