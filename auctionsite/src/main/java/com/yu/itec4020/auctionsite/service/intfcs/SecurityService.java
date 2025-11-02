package com.yu.itec4020.auctionsite.service.intfcs;

public interface SecurityService {
    String findLoggedInUsername();

    void autoLogin(String username, String password);
}
