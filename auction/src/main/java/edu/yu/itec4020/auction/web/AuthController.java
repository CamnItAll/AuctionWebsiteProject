package edu.yu.itec4020.auction.web;

// ⬇️ imports (put at the top of AuthController.java)
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import edu.yu.itec4020.auction.service.UserService;
import edu.yu.itec4020.auction.web.dto.LoginRequest;
import edu.yu.itec4020.auction.web.dto.ProfileView;
import edu.yu.itec4020.auction.web.dto.SignupRequest;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthenticationManager authManager;
    private final UserService users;

    public AuthController(AuthenticationManager authManager, UserService users) {
        this.authManager = authManager;
        this.users = users;
    }

    @PostMapping("/signup")
    public ResponseEntity<ProfileView> signup(@RequestBody SignupRequest r) {
        var u = users.signup(r);
        return ResponseEntity.status(HttpStatus.CREATED).body(ProfileView.from(u));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest r,
                                   HttpServletRequest req,
                                   HttpServletResponse res) {
        var auth = authManager.authenticate(
                new UsernamePasswordAuthenticationToken(r.username(), r.password())
        );

        var context = org.springframework.security.core.context.SecurityContextHolder.createEmptyContext();
        context.setAuthentication(auth);
        org.springframework.security.core.context.SecurityContextHolder.setContext(context);

        // Explicitly save the SecurityContext to the HTTP session:
        new org.springframework.security.web.context.HttpSessionSecurityContextRepository()
                .saveContext(context, req, res);

        // ensure session exists
        req.getSession(true);

        return ResponseEntity.ok(java.util.Map.of("message", "ok"));
    }


    @PostMapping("/forgot")
    public ResponseEntity<?> forgot(@RequestBody Map<String,String> body){
        return ResponseEntity.noContent().build(); // stub for D1
    }
}
