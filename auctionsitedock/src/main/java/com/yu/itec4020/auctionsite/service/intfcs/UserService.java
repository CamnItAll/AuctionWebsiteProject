package com.yu.itec4020.auctionsite.service.intfcs;

import com.yu.itec4020.auctionsite.model.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}