package com.aaj.movie.backend.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.aaj.movie.backend.dto.MovieDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.backend.service.MovieService;
import com.aaj.movie.entity.Movie;


@RestController
@RequestMapping("admin/api/movies")
public class adminMovieController {
    
    @Autowired
    private MovieService movieService;

    @GetMapping
    public List<MovieDTO> getAllMovies(){
        return movieService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<MovieDTO> getMovieById(@PathVariable Long id){
        Optional<MovieDTO> movie = movieService.findMovieById(id);
        return movie.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<MovieDTO> createMovie(
            @RequestParam(value = "posterImage", required = false) MultipartFile posterImage,
            @RequestParam("title") String title,
            @RequestParam("director") String director,
            @RequestParam(value = "subtitles", required = false) List<String> subtitles, // 直接接收 List<String>
            @RequestParam("rating") String rating,
            @RequestParam("description") String description,
            @RequestParam("premiereDate") LocalDate premiereDate,
            @RequestParam("duration") Integer duration) {
 
        Movie movie = new Movie();
        movie.setTitle(title);
        movie.setDirector(director);
        movie.setSubtitles(subtitles);
        movie.setRating(rating);
        movie.setDescription(description);
        movie.setPremiereDate(premiereDate);
        movie.setDuration(duration);
    
        if (posterImage != null && !posterImage.isEmpty()) {
            try {
                // 檔案儲存路徑
                String uploadDir = "src/main/resources/static/frontend/img/";
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
    
                // 建立獨一無二的檔名
                // String uniqueFilename = System.currentTimeMillis() + "_" + posterImage.getOriginalFilename();
                Path filePath = uploadPath.resolve(posterImage.getOriginalFilename());
                Files.copy(posterImage.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
    
                // 設定要存入資料庫的 URL
                movie.setPosterUrl("/frontend/img/" + posterImage.getOriginalFilename());
    
            } catch (IOException e) {
                // 在真實世界中，這裡應該要有更詳細的 log 和錯誤回報
                System.err.println("File upload failed: " + e.getMessage());
                // 您可以選擇回傳一個錯誤訊息
                return ResponseEntity.internalServerError().build();
            }
        }
    
        Movie savedMovie = movieService.saveMovie(movie);
        return ResponseEntity.ok(EntityDTOMapper.toMovieDTO(savedMovie));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MovieDTO> updateMovie(
        @PathVariable Long id,
        @RequestParam(value = "posterImage", required = false) MultipartFile posterImage,
        @RequestParam("title") String title,
        @RequestParam("director") String director,
        @RequestParam(value = "subtitles", required = false) List<String> subtitles,
        @RequestParam("rating") String rating,
        @RequestParam("description") String description,
        @RequestParam("premiereDate") LocalDate premiereDate,
        @RequestParam("duration") Integer duration) {

        // 1. 先從資料庫找出要更新的電影
        Optional<Movie> optionalMovie = movieService.findMovieEntityById(id);
        if (!optionalMovie.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        Movie movieToUpdate = optionalMovie.get();

        // 2. 更新所有文字和非檔案類型的欄位
        movieToUpdate.setTitle(title);
        movieToUpdate.setDirector(director);
        movieToUpdate.setSubtitles(subtitles);
        movieToUpdate.setRating(rating);
        movieToUpdate.setDescription(description);
        movieToUpdate.setPremiereDate(premiereDate);
        movieToUpdate.setDuration(duration);

        // 3. 檢查是否有新的圖片檔案被上傳
        if (posterImage != null && !posterImage.isEmpty()) {
            try {
                // (可選，但建議) 刪除舊的圖片檔案，避免留下垃圾檔案
                if (movieToUpdate.getPosterUrl() != null && !movieToUpdate.getPosterUrl().isEmpty()) {
                    Path oldImagePath = Paths.get("src/main/resources/static" + movieToUpdate.getPosterUrl());
                    if (Files.exists(oldImagePath)) {
                        Files.delete(oldImagePath);
                    }
                }

                // 儲存新圖片 (這段邏輯和 createMovie 一樣)
                String uploadDir = "src/main/resources/static/frontend/img/";
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                // String uniqueFilename = System.currentTimeMillis() + "_" + posterImage.getOriginalFilename();
                Path filePath = uploadPath.resolve(posterImage.getOriginalFilename());
                Files.copy(posterImage.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                // 更新資料庫中的 posterUrl
                movieToUpdate.setPosterUrl("/frontend/img/" + posterImage.getOriginalFilename());

            } catch (IOException e) {
                System.err.println("File upload failed during update: " + e.getMessage());
                return ResponseEntity.internalServerError().build();
            }
        }

        // 4. 儲存更新後的 movie 物件
        Movie updatedMovie = movieService.saveMovie(movieToUpdate);
        return ResponseEntity.ok(EntityDTOMapper.toMovieDTO(updatedMovie));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMovie(@PathVariable Long id){
        if (movieService.findMovieEntityById(id).isPresent()) {
            movieService.deleteMovie(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}