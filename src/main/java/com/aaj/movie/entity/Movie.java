package com.aaj.movie.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "movies")
public class Movie {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="title", length = 100, nullable = false)
    private String title;

    @Column(name="director", length = 50)
    private String director;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "movie_subtitles", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name="subtitle")
    private List<String> subtitles = new ArrayList<>();;

    @Column(name="rating", length = 20)
    private String rating;

    @Column(name="description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "premiere_date")
    private LocalDate premiereDate;

    @Column(name = "duration")
    private Integer duration;
    
    @Column(name = "poster_url", length = 255)
    private String posterUrl;

    @OneToMany(mappedBy="movie", fetch=FetchType.LAZY)
    private List<Showtime> showtimes = new ArrayList<>();

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
    
    @JsonIgnore
    public List<Showtime> getShowtimes() {
        return showtimes;
    }

    public void setShowtimes(List<Showtime> showtimes) {
        this.showtimes = showtimes;
    }
}
