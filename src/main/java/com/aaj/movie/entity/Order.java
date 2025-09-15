package com.aaj.movie.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="user_orders")
public class Order {
    
    public Order() {
    }

    public Order(Long orderId, String orderNumber, User user, BigDecimal totalAmount, OrderStatus status,
            String linepayTransactionId, LocalDateTime createdAt, List<Ticket> tickets) {
        this.orderId = orderId;
        this.orderNumber = orderNumber;
        this.user = user;
        this.totalAmount = totalAmount;
        this.status = status;
        this.linepayTransactionId = linepayTransactionId;
        this.createdAt = createdAt;
        this.tickets = tickets;
    }

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id")
    private Long orderId;

    @Column(name="order_number", unique=true)
    private String orderNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="user_id", nullable=false)
    private User user;

    @Column(name="total_amount", precision=10, scale=2)
    private BigDecimal totalAmount;

    @Enumerated(EnumType.STRING)
    @Column(name="status", nullable=false)
    private OrderStatus status = OrderStatus.PENDING;

    @Column(name="linepay_transaction_id", unique=true)
    private String linepayTransactionId;

    @CreationTimestamp
    @Column(name="created_at", updatable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy="order", fetch=FetchType.LAZY)
    @JsonIgnore
    private List<Ticket> tickets;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public String getLinepayTransactionId() {
        return linepayTransactionId;
    }

    public void setLinepayTransactionId(String linepayTransactionId) {
        this.linepayTransactionId = linepayTransactionId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    


}
