package com.aaj.movie.backend.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.User;

public interface UserDAO extends JpaRepository<User, Long>{
    
}
