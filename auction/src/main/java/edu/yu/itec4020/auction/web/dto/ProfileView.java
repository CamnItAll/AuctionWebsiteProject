package edu.yu.itec4020.auction.web.dto;

import edu.yu.itec4020.auction.domain.User;

public record ProfileView(Integer id, String username, String firstName, String lastName,
                          String addressStreet, String addressNo, String city, String country, String postalCode) {
    public static ProfileView from(User u){
        return new ProfileView(u.getId(), u.getUsername(), u.getFirstName(), u.getLastName(),
                u.getAddressStreet(), u.getAddressNo(), u.getCity(), u.getCountry(), u.getPostalCode());
    }
}