package com.aaj.movie.backend.mapper;

import java.util.Collections;
import java.util.stream.Collectors;

import com.aaj.movie.backend.dto.MovieDTO;
import com.aaj.movie.backend.dto.OrderDTO;
import com.aaj.movie.backend.dto.ShowtimeDTO;
import com.aaj.movie.backend.dto.TicketDTO;
import com.aaj.movie.backend.dto.UserDTO;
import com.aaj.movie.entity.Movie;
import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.Showtime;
import com.aaj.movie.entity.Ticket;
import com.aaj.movie.entity.User;

public class EntityDTOMapper {

    public static ShowtimeDTO toShowtimeDTO(Showtime showtime) {
        if (showtime == null) {
            return null;
        }
        ShowtimeDTO dto = new ShowtimeDTO();
        dto.setId(showtime.getId());
        dto.setStartTime(showtime.getStartTime());
        dto.setPrice(showtime.getPrice());
        if (showtime.getMovie() != null) {
            dto.setMovieId(showtime.getMovie().getId());
            dto.setMovieTitle(showtime.getMovie().getTitle());
        }
        return dto;
    }

    public static MovieDTO toMovieDTO(Movie movie) {
        if (movie == null) {
            return null;
        }
        MovieDTO dto = new MovieDTO();
        dto.setId(movie.getId());
        dto.setTitle(movie.getTitle());
        dto.setDirector(movie.getDirector());
        dto.setSubtitles(movie.getSubtitles());
        dto.setRating(movie.getRating());
        dto.setDescription(movie.getDescription());
        dto.setPremiereDate(movie.getPremiereDate());
        dto.setDuration(movie.getDuration());
        dto.setPosterUrl(movie.getPosterUrl());

        if (movie.getShowtimes() != null) {
            dto.setShowtimes(
                    movie.getShowtimes().stream()
                            .map(EntityDTOMapper::toShowtimeDTO)
                            .collect(Collectors.toList())
            );
        }
        return dto;
    }

    public static TicketDTO toTicketDTO(Ticket ticket) {
        if (ticket == null) {
            return null;
        }
        TicketDTO dto = new TicketDTO();
        dto.setId(ticket.getId());

        if (ticket.getShowtime() != null) {
            dto.setShowtimeStartTime(ticket.getShowtime().getStartTime());
            if (ticket.getShowtime().getMovie() != null) {
                dto.setMovieTitle(ticket.getShowtime().getMovie().getTitle());
            }
        }
        if (ticket.getSeat() != null) {
            dto.setSeatRow(ticket.getSeat().getSeatRow());
            dto.setSeatNumber(ticket.getSeat().getNumber());
        }
        return dto;
    }

    public static OrderDTO toOrderDTO(Order order) {
        if (order == null) {
            return null;
        }
        OrderDTO dto = new OrderDTO();
        dto.setOrderId(order.getOrderId());
        dto.setOrderNumber(order.getOrderNumber());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setLinepayTransactionId(order.getLinepayTransactionId());
        dto.setCreatedAt(order.getCreatedAt());

        if (order.getStatus() != null) {
            dto.setStatus(order.getStatus().name());
        }

        if (order.getUser() != null) {
            dto.setUserAccount(order.getUser().getAccount());
        }

        if (order.getTickets() != null && !order.getTickets().isEmpty()) {
            dto.setTickets(
                    order.getTickets().stream()
                            .map(EntityDTOMapper::toTicketDTO)
                            .collect(Collectors.toList())
            );
        } else {
            dto.setTickets(Collections.emptyList()); // 如果沒有票券，返回一個空列表
        }
        return dto;
    }

    public static UserDTO toUserDTO(User user){
        if (user == null){
            return null;
        }
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setAccount(user.getAccount());
        return dto;
    }
}
