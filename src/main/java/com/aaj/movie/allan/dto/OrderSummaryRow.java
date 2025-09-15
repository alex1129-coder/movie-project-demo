package com.aaj.movie.allan.dto;

import java.math.BigDecimal;
import java.util.Date;

import com.aaj.movie.entity.OrderStatus;

// 這是一列要給畫面看的資料（電影、時間、座位、金額、狀態）
public class OrderSummaryRow {
    private final String movieTitle;
    private final Date showtime;          // 給 <fmt:formatDate/> 最穩用 java.util.Date
    private final String seats;           // 例如 "A5, A6"
    private final BigDecimal totalAmount; // 金額
    private final OrderStatus status;     // 訂單狀態

    public OrderSummaryRow(String movieTitle, Date showtime, String seats,
                           BigDecimal totalAmount, OrderStatus status) {
        this.movieTitle = movieTitle;
        this.showtime = showtime;
        this.seats = seats;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public String getMovieTitle() { return movieTitle; }
    public Date getShowtime() { return showtime; }
    public String getSeats() { return seats; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public OrderStatus getStatus() { return status; }
}