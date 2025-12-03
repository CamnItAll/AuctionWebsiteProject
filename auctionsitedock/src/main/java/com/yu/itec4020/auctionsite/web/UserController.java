package com.yu.itec4020.auctionsite.web;

import com.yu.itec4020.auctionsite.model.User;
import com.yu.itec4020.auctionsite.service.intfcs.SecurityService;
import com.yu.itec4020.auctionsite.service.intfcs.UserService;
import com.yu.itec4020.auctionsite.conf.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private SecurityService securityService;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "register";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "register";
        }
        userService.save(userForm);

        return "redirect:/login?registered=true";
    }

    @GetMapping("/login")
    public String login(Model model, String error, String logout, String registered) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");
        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");
        if (registered != null)
            model.addAttribute("message", "Registration successful! You may now log in.");

        return "login";
    }
    
    @GetMapping("/forgot-password")
    public String showForgotPasswordForm(Model model) {
        return "forgotpass";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("username") String username, Model model) {
        User user = userService.findByUsername(username);
        if (user == null) {
            model.addAttribute("error", "No account found with that username.");
            return "forgotpass";
        }
        model.addAttribute("username", username);
        return "resetpass";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(
    		@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("passwordConfirm") String passwordConfirm,
            Model model) {
        if (!password.equals(passwordConfirm)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("username", username);
            return "resetpass";
        }
        User user = userService.findByUsername(username);
        if (user == null) {
            model.addAttribute("error", "Invalid username.");
            return "forgotpass";
        }
        user.setPassword(password);
        userService.save(user); // This re-hashes via BCrypt in your UserServiceImpl
        model.addAttribute("message", "Password successfully updated!");
        securityService.autoLogin(user.getUsername(), password);

        return "login";
    }
    
    @GetMapping("/")
    public String rootRedirect() {
        return "redirect:/login";
    }

    @GetMapping("/catalogue")
    public String catalogue(Model model) {
        return "redirect:/catalogue/";
    }
}
