package edu.yu.itec4020.auction.service;

import edu.yu.itec4020.auction.domain.User;
import edu.yu.itec4020.auction.repo.UserRepository;
import edu.yu.itec4020.auction.web.dto.AddressUpdate;
import edu.yu.itec4020.auction.web.dto.PasswordChange;
import edu.yu.itec4020.auction.web.dto.ProfileView;
import edu.yu.itec4020.auction.web.dto.SignupRequest;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;

@Service
public class UserService {

    private final UserRepository repo;
    private final PasswordEncoder encoder;

    public UserService(UserRepository repo, PasswordEncoder encoder) {
        this.repo = repo;
        this.encoder = encoder;
    }

    @Transactional
    public User signup(SignupRequest r) {
        repo.findByUsername(r.username())
                .ifPresent(u -> { throw new ResponseStatusException(HttpStatus.CONFLICT, "Username already exists"); });

        User u = new User();
        u.setUsername(r.username());
        u.setPasswordHash(encoder.encode(r.password()));
        u.setFirstName(r.firstName());
        u.setLastName(r.lastName());
        u.setAddressStreet(r.addressStreet());
        u.setAddressNo(r.addressNo());
        u.setCity(r.city());
        u.setCountry(r.country());
        u.setPostalCode(r.postalCode());
        u.setCreatedAt(Instant.now().toString());

        return repo.save(u);
    }

    @Transactional(readOnly = true)
    public ProfileView view(String username) {
        User u = repo.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        return ProfileView.from(u);
    }

    @Transactional
    public void updateAddress(String username, AddressUpdate r) {
        User u = repo.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        u.setAddressStreet(r.addressStreet());
        u.setAddressNo(r.addressNo());
        u.setCity(r.city());
        u.setCountry(r.country());
        u.setPostalCode(r.postalCode());
        // no repo.save(...) needed; JPA flushes on tx commit
    }

    @Transactional
    public void changePassword(String username, PasswordChange r) {
        User u = repo.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        if (!encoder.matches(r.oldPassword(), u.getPasswordHash())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Old password incorrect");
        }
        u.setPasswordHash(encoder.encode(r.newPassword()));
    }
}
