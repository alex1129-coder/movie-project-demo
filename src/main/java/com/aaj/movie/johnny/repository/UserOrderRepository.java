package com.aaj.movie.johnny.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.User;


public interface UserOrderRepository extends JpaRepository<Order, Long>{
        List<Order> findByUser(User user);

}
