package edu.yu.itec4020.auction.web;

import edu.yu.itec4020.auction.service.UserService;
import edu.yu.itec4020.auction.web.dto.AddressUpdate;
import edu.yu.itec4020.auction.web.dto.PasswordChange;
import edu.yu.itec4020.auction.web.dto.ProfileView;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
public class ProfileController {

    private final UserService users;

    public ProfileController(UserService users) {
        this.users = users;
    }

    @GetMapping("/me")
    public ProfileView me(Authentication auth) {
        return users.view(auth.getName());
    }

    @PutMapping("/me/address")
    public ResponseEntity<Void> updateAddress(Authentication auth,
                                              @RequestBody @Valid AddressUpdate r) {
        users.updateAddress(auth.getName(), r);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/me/password")
    public ResponseEntity<Void> changePassword(Authentication auth,
                                               @RequestBody @Valid PasswordChange r) {
        users.changePassword(auth.getName(), r);
        return ResponseEntity.noContent().build();
    }
}
