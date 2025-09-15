package com.aaj.movie.backend.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Admin;

public interface AdminDAO extends JpaRepository<Admin, Long> {

    // 根據帳號尋找管理員，Spring Data JPA 會自動實作它
    Optional<Admin> findByAccount(String account);
}
