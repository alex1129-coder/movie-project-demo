package com.aaj.movie.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaj.movie.backend.dao.ShowtimeDAO;
import com.aaj.movie.backend.dto.ShowtimeDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.entity.Showtime;

@Service
public class ShowtimeService {
    
    @Autowired
    private ShowtimeDAO showtimeDAO;

    public List<ShowtimeDTO> findAll(){
        return showtimeDAO.findAll().stream()
                .map(EntityDTOMapper::toShowtimeDTO)
                .collect(Collectors.toList());
    }

    public Optional<ShowtimeDTO> findShowtimeById(Long id){
        return showtimeDAO.findById(id)
                            .map(EntityDTOMapper::toShowtimeDTO);
    }

    public Optional<Showtime> findShowtimeEntityById(Long id) {
        return showtimeDAO.findById(id);
    }

    public Showtime saveShowtime(Showtime showtime){
        return showtimeDAO.save(showtime);
    }

    public void deleteShowtime(Long id){
        showtimeDAO.deleteById(id);
    }
}
