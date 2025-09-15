package com.aaj.movie.backend.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aaj.movie.backend.dto.ShowtimeDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.backend.service.ShowtimeService;
import com.aaj.movie.entity.Showtime;

@RestController
@RequestMapping("/admin/api/showtimes")
public class adminShowtimeController {
    
    @Autowired
    ShowtimeService showtimeService;

    @GetMapping
    public List<ShowtimeDTO> getAllShowtime(){
        return showtimeService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ShowtimeDTO> getShowtimeById(@PathVariable Long id){
        Optional<ShowtimeDTO> showtime = showtimeService.findShowtimeById(id);
        return showtime.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<ShowtimeDTO> createShowtime(@RequestBody Showtime showtime){
        Showtime savedShowtime = showtimeService.saveShowtime(showtime);
        return ResponseEntity.ok(EntityDTOMapper.toShowtimeDTO(savedShowtime));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ShowtimeDTO> updateShowtime(@PathVariable Long id, @RequestBody Showtime showtimeDetails){
        return showtimeService.findShowtimeEntityById(id).map(showtimeToUpdate -> {
            BeanUtils.copyProperties(showtimeDetails, showtimeToUpdate, "id");
            Showtime updatedShowtime = showtimeService.saveShowtime(showtimeToUpdate);
            return ResponseEntity.ok(EntityDTOMapper.toShowtimeDTO(updatedShowtime));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteShowtime(@PathVariable Long id){
        if (showtimeService.findShowtimeEntityById(id).isPresent()) {
            showtimeService.deleteShowtime(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
