package com.aaj.movie.backend.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Order;

public interface OrderDAO extends JpaRepository<Order, Long> {

}
