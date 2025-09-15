package com.aaj.movie.backend.dto;

import java.time.LocalDate;
import java.util.List;

// 這個 DTO 用於向前端呈現電影的完整資訊
public class MovieDTO {
    
    private Long id;
    private String title;
    private String director;
    private List<String> subtitles;
    private String rating;
    private String description;
    private LocalDate premiereDate;
    private Integer duration;
    private String posterUrl;
    private List<ShowtimeDTO> showtimes;
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDirector() {
        return director;
    }
    public void setDirector(String director) {
        this.director = director;
    }
    public List<String> getSubtitles() {
        return subtitles;
    }
    public void setSubtitles(List<String> subtitles) {
        this.subtitles = subtitles;
    }
    public String getRating() {
        return rating;
    }
    public void setRating(String rating) {
        this.rating = rating;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public LocalDate getPremiereDate() {
        return premiereDate;
    }
    public void setPremiereDate(LocalDate premiereDate) {
        this.premiereDate = premiereDate;
    }
    public Integer getDuration() {
        return duration;
    }
    public void setDuration(Integer duration) {
        this.duration = duration;
    }
    public String getPosterUrl() {
        return posterUrl;
    }
    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }
    public List<ShowtimeDTO> getShowtimes() {
        return showtimes;
    }
    public void setShowtimes(List<ShowtimeDTO> showtimes) {
        this.showtimes = showtimes;
    }

    
}
