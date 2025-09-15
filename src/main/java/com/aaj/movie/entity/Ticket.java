package com.aaj.movie.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name="tickets", uniqueConstraints=@UniqueConstraint(columnNames = {"showtime_id", "seat_id"}))
public class Ticket {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="order_id", nullable=false)
    private Order order;

    @ManyToOne
    @JoinColumn(name="showtime_id", nullable=false)
    private Showtime showtime;

    @ManyToOne
    @JoinColumn(name="seat_id", nullable=false)
    private Seat seat;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

        // 無參數建構子
    public Ticket() {}

    // ✅ 新增帶參數建構子
    public Ticket(Order order, Seat seat, Showtime showtime) {
        this.order = order;
        this.seat = seat;
        this.showtime = showtime;
    }


    
}
