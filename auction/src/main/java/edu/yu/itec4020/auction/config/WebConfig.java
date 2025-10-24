package edu.yu.itec4020.auction.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.ErrorPageFilter;

@Configuration
public class WebConfig {

    @Bean(name = "errorPageFilterRegistration")
    public FilterRegistrationBean<ErrorPageFilter>
    disableErrorPageFilter(ErrorPageFilter filter) {
        FilterRegistrationBean<ErrorPageFilter> reg =
                new FilterRegistrationBean<>(filter);
        reg.setEnabled(false); // prevent container registration on external Tomcat
        return reg;
    }
}
