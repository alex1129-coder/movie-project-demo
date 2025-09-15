package com.aaj.movie.backend.dto;

import java.time.LocalDateTime;

public class TicketDTO {
    
    private Long id;
    private String movieTitle;
    private LocalDateTime showtimeStartTime;
    private String seatRow;
    private int seatNumber;
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getMovieTitle() {
        return movieTitle;
    }
    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }
    public LocalDateTime getShowtimeStartTime() {
        return showtimeStartTime;
    }
    public void setShowtimeStartTime(LocalDateTime showtimeStartTime) {
        this.showtimeStartTime = showtimeStartTime;
    }
    public String getSeatRow() {
        return seatRow;
    }
    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }
    public int getSeatNumber() {
        return seatNumber;
    }
    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    
}
