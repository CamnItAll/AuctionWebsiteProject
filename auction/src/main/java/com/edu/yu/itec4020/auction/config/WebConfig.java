package com.edu.yu.itec4020.auction.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.ErrorPageFilter;

@Configuration
public class WebConfig {

    @Bean(name = "errorPageFilterRegistration")
    public FilterRegistrationBean<ErrorPageFilter> disableErrorPageFilter() {
        FilterRegistrationBean<ErrorPageFilter> reg =
                new FilterRegistrationBean<>(new ErrorPageFilter());
        reg.setEnabled(false); // disable it for WAR deployments
        return reg;
    }
}