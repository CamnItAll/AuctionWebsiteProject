package com.edu.yu.itec4020.auction.web.dto;

public record SignupRequest(
        String username, String password, String firstName, String lastName,
        String addressStreet, String addressNo, String city, String country, String postalCode) {}