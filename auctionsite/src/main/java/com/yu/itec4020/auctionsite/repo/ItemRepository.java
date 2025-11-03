package com.yu.itec4020.auctionsite.repo;

import com.yu.itec4020.auctionsite.model.Item;
import java.util.*;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long>{
	List<Item> findByNameContaining(String keyword);
	
	List<Item> findByAuctionType(String auctionType);
	
	Item findById(int itemId);
}
