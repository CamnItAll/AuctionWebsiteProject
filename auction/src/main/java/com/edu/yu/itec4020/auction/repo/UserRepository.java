package com.edu.yu.itec4020.auction.repo;

import com.edu.yu.itec4020.auction.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);
}
