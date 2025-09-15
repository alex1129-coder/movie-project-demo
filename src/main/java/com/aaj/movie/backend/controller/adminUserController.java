package com.aaj.movie.backend.controller;

import java.util.List;

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

import com.aaj.movie.backend.dao.UserDAO;
import com.aaj.movie.backend.dto.UserDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.backend.service.UserService;
import com.aaj.movie.entity.User;

@RestController
@RequestMapping("/admin/api/users")
public class adminUserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserDAO userDAO;

    public static class UserCreateRequest {
        public String name;
        public String account;
        public String password;
    }

    @GetMapping
    public List<UserDTO> getAllUsers() {
        return userService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
        return userService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public UserDTO createUser(@RequestBody UserCreateRequest request) {
        User newUser = new User();
        newUser.setName(request.name);
        newUser.setAccount(request.account);
        newUser.setPassword(request.password); // Pass plain password to service

        User createdUser = userService.createUser(newUser);

        return EntityDTOMapper.toUserDTO(createdUser);
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(@PathVariable Long id,
                                              @RequestBody UserCreateRequest request) {
        return userService.findById(id)
                .map(existingUserDTO -> {
                    User updatedUser = new User();
                    updatedUser.setId(id); // 記得要帶上 id 才會更新
                    updatedUser.setName(request.name);
                    updatedUser.setAccount(request.account);
                    updatedUser.setPassword(request.password); // Service 會處理 hash

                    User savedUser = userService.updateUser(updatedUser);
                    return ResponseEntity.ok(EntityDTOMapper.toUserDTO(savedUser));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        if (!userDAO.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        userService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

