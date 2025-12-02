package com.yu.itec4020.auctionsite.conf;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private final UserDetailsService userDetailsService;

    public WebSecurityConfig(@Qualifier("authenService") UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
            		.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
            		.requestMatchers(
	                    "/login", "/registration", "/forgot-password", "/reset-password",
	                    "/css/**", "/js/**", "/images/**", "/webjars/**"
	            		).permitAll()
            	.requestMatchers(
            			"/catalogue/new", "/catalogue/save", "/catalogue/create",
            			"/auction/pay/{itemId}", "/auction/placeBid/{itemId}", "/auction/updateDutchPrice/{itemId}",
            			"/payment/{itemId}/pay", "/payment/{itemId}/receipt"
            			).authenticated()
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")// GET /login -> your JSP
                .loginProcessingUrl("/perform_login")// POST /perform_login -> Spring Security handles login
                .defaultSuccessUrl("/catalogue", true) // Redirect here after success
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/perform_logout")
                .logoutSuccessUrl("/login?logout=true")
                .deleteCookies("JSESSIONID")
                .permitAll()
            );

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }
}
