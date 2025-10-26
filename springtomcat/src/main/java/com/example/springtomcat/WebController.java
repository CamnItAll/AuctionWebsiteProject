package com.example.springtomcat;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@Controller
public class WebController {
    @GetMapping("/") 
    public String testing()
    {
    	return "index";
    }
}