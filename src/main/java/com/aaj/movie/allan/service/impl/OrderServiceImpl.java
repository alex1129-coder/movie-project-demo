package com.aaj.movie.allan.service.impl;

import java.math.BigDecimal;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.OrderStatus;
import com.aaj.movie.entity.User;
import com.aaj.movie.allan.Repository.OrderRepository;
import com.aaj.movie.allan.service.OrderService;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository repo;
    private final EntityManager em;

    public OrderServiceImpl(OrderRepository repo, EntityManager em) {
        this.repo = repo;
        this.em = em;
    }

    @Override
    @Transactional
    public Order create(Long userId, BigDecimal totalAmount, String orderNumber) {
        Order o = new Order();
        // 不額外查 DB，直接用 reference 綁定現有的 user 主鍵
        User refUser = em.getReference(User.class, userId);
        o.setUser(refUser);
        o.setTotalAmount(totalAmount);
        o.setOrderNumber(orderNumber);
        o.setStatus(OrderStatus.PENDING);
        return repo.save(o);
    }

    @Override
    @Transactional(readOnly = true)
    public Order getByOrderNumber(String orderNumber) {
        return repo.findByOrderNumber(orderNumber)
                   .orElseThrow(() -> new EntityNotFoundException("Order not found: " + orderNumber));
    }

    @Override
    @Transactional
    public Order markPending(String orderNumber) {
        Order o = getByOrderNumber(orderNumber);
        o.setStatus(OrderStatus.PENDING);
        return o; // 受控實體，交易結束會自動 flush；若想顯式也可 repo.save(o)
    }

    @Override
    @Transactional
    public Order markPaid(String orderNumber, String transactionId) {
        Order o = getByOrderNumber(orderNumber);
        o.setStatus(OrderStatus.PAID);
        o.setLinepayTransactionId(transactionId);
        return o;
    }

    @Override
    @Transactional
    public Order markFailed(String orderNumber) {
        Order o = getByOrderNumber(orderNumber);
        o.setStatus(OrderStatus.FAILED);
        return o;
    }

    @Override
    @Transactional
    public Order markCancelled(String orderNumber) {
        Order o = getByOrderNumber(orderNumber);
        o.setStatus(OrderStatus.CANCELLED);
        return o;
    }

    @Override
    @Transactional
    public Order markRefunded(String orderNumber) {
        Order o = getByOrderNumber(orderNumber);
        o.setStatus(OrderStatus.REFUNDED);
        return o;
    }
}
