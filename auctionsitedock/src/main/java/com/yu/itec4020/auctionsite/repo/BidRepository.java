package com.yu.itec4020.auctionsite.repo;

import java.util.List;
import com.yu.itec4020.auctionsite.model.Bid;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BidRepository extends JpaRepository<Bid, Long> {
    List<Bid> findByItemId(int itemId);
}