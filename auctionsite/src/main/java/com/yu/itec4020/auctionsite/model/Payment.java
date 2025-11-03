package com.yu.itec4020.auctionsite.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "buyer_id", nullable = false)
    private User buyer;

    @ManyToOne
    @JoinColumn(name = "item_id", nullable = false)
    private Item item;
    
    @Column(name = "amount_paid", nullable = false)
    private Double amountPaid;
    
    @Column(name = "card_num", nullable = false)
    private String cardNum;
    
    @Column(name = "card_name", nullable = false)
    private String cardName;
    
    @Column(name = "expire_date", nullable = false)
    private String expireDate;
    
    @Column(nullable = false)
    private String cvv;
    
    @Column(name = "payment_date", nullable = false)
    private LocalDateTime paymentDate = LocalDateTime.now();

    // ---------- Getters and Setters ----------
    public Integer getPaymentId() { return id; }
    public void setPaymentId(Integer id) { this.id = id; }
    
    public User getBuyer() { return buyer; }
    public void setBuyer(User buyer) { this.buyer = buyer; }
    
    public Item getItem() { return item; }
    public void setItem(Item item) { this.item = item; }
    
    public Double getAmount() { return amountPaid; }
    public void setAmount(Double amountPaid) { this.amountPaid = amountPaid; }

    public String getCardNum() { return cardNum; }
    public void setCardNum(String cardNum) { this.cardNum = cardNum; }

    public String getCardName() { return cardName; }
    public void setCardName(String cardName) { this.cardName = cardName; }
    
    public String getExpireDate() { return expireDate; }
    public void setExpireDate(String expireDate) { this.expireDate = expireDate; }
    
    public String getCvv() { return cvv; }
    public void setCvv(String cvv) { this.cvv = cvv; }
    
    public LocalDateTime getPaymentDate() { return paymentDate; }
}

