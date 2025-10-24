package com.example.springtomcat;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping
public class WebController {
    @GetMapping("/") 
    public String getMessage()
    {
        return "Hello, you fucking indecisive son of a bitch, I mean CHRIST how many times are you gonna drive aspiring students up the fucking wall until you've been satisfied???";
    }
}