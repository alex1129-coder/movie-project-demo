package com.aaj.movie.backend.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class OrderDTO {
    
    private Long orderId;
    private String orderNumber;
    private String userAccount;
    private BigDecimal totalAmount;
    private String status;
    private String linepayTransactionId;
    private LocalDateTime createdAt;
    private List<TicketDTO> tickets;
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
    public String getUserAccount() {
        return userAccount;
    }
    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
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
    public List<TicketDTO> getTickets() {
        return tickets;
    }
    public void setTickets(List<TicketDTO> tickets) {
        this.tickets = tickets;
    }

    
}
