package com.vel.springsecurityapp.service;

import com.vel.springsecurityapp.model.User;

/**
 * Service class for {@link com.vel.springsecurityapp.model.User}
 *
 * @author Wladimir
 * @version 1.0
 */

public interface UserService {

    void save(User user);

    User findByUsername(String username);
}
