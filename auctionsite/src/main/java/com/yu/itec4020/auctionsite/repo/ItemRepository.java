package com.yu.itec4020.auctionsite.repo;

import com.yu.itec4020.auctionsite.model.Item;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {

    Item findById(int id);

    List<Item> findByNameContaining(String keyword);

    @Query("SELECT i FROM Item i WHERE i.payment IS NULL")
    List<Item> findAllUnpaid();

    @Query("SELECT i FROM Item i WHERE i.payment IS NULL AND LOWER(i.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Item> searchUnpaidByName(@Param("keyword") String keyword);
}
