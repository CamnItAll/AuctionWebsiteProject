package com.yu.itec4020.auctionsite.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

import com.yu.itec4020.auctionsite.model.enums.AuctionType;

@Entity
@Table(name = "items")
public class Item {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(nullable = false)
    private String name;
	
	@Column(nullable = false)
    private String description;
	
	@Column(name = "start_price", nullable = false)
    private Double startPrice;
	
	@Column(name = "current_price",nullable = false)
    private Double currentPrice;
	
	@Column(name = "auction_status", nullable = false)
	private String auctionStatus = "OPEN";
	
	@Column(name = "start_date", nullable = false)
	private LocalDateTime startDate = LocalDateTime.now();
	
	@Column(name = "end_date", nullable = false)
	private LocalDateTime endDate;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "auction_type")
	private AuctionType auctionType; // "forward" or "dutch"
	
	@Column(name = "shipping_price", nullable = false)
    private Double shippingPrice;
	
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
    
    @OneToOne(mappedBy = "item")
    private Payment payment;
	
	// ---------- Getters and Setters ----------
    public Long getItemId() { return id; }
    public void setItemId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Double getStartPrice() { return startPrice; }
    public void setStartPrice(Double startPrice) { this.startPrice = startPrice; }
    
    public Double getCurrentPrice() { return currentPrice; }
    public void setCurrentPrice(Double currentPrice) { this.currentPrice = currentPrice; }
    
    public String getAuctionStatus() { return auctionStatus; }
    public void setAuctionStatus(String auctionStatus) { this.auctionStatus = auctionStatus; }
    
    public LocalDateTime getStartDate() { return startDate; }
    
    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }
    
    public AuctionType getAuctionType() { return auctionType; }
    public void setAuctionType(AuctionType auctionType) { this.auctionType = auctionType; }
    
    public Double getShippingPrice() { return shippingPrice; }
    public void setShippingPrice(Double shippingPrice) { this.shippingPrice = shippingPrice; }
    
    public Double getExpeditedShippingPrice() { return expeditedShippingPrice; }
    public void setExpeditedShippingPrice(Double expeditedShippingPrice) { this.expeditedShippingPrice = expeditedShippingPrice; }
    
    public Integer getShippingDays() { return shippingDays; }
    public void setShippingDays(Integer shippingDays) { this.shippingDays = shippingDays; }
    
    public User getOwner() { return owner; }
    public void setOwner(User owner) { this.owner = owner; }
    
    public User getHighestBidder() { return highestBidder; }
    public void setHighestBidder(User highestBidder) { this.highestBidder = highestBidder; }
    
    public Payment getPayment() { return payment; }
    public void setPayment(Payment payment) { this.payment = payment; }
}
