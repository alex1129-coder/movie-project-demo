package com.aaj.movie.johnny.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByAccount(String account);
}
