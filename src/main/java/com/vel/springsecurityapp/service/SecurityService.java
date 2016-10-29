package com.vel.springsecurityapp.service;

/**
 * Service for Security.
 *
 * @author Wladimir
 * @version 1.0
 */

public interface SecurityService {

    String findLoggedInUsername();

    void autoLogin(String username, String password);
}
