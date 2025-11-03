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
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

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
        securityService.autoLogin(userForm.getUsername(), userForm.getPassword());

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
    
    @GetMapping("/")
    public String rootRedirect() {
        return "redirect:/login";
    }

    @GetMapping("/catalogue")
    public String catalogue(Model model) {
        return "catalogue";
    }
}
