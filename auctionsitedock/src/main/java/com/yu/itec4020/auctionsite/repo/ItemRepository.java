package com.yu.itec4020.auctionsite.repo;

import com.yu.itec4020.auctionsite.model.Item;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {

    Item findById(int id);

    // For search function (used earlier in project for testing)
    List<Item> findByNameContaining(String keyword);

    // Find items that haven't been paid for yet (i.e. not connected to a payment object)
    @Query("SELECT i FROM Item i WHERE i.payment IS NULL")
    List<Item> findAllUnpaid();

    // Also for search function, but filters out paid-for items
    @Query("SELECT i FROM Item i WHERE i.payment IS NULL AND LOWER(i.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Item> searchUnpaidByName(@Param("keyword") String keyword);
}
