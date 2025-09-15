package com.aaj.movie.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaj.movie.backend.dao.UserDAO;
import com.aaj.movie.backend.dto.UserDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.entity.User;

@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    // PasswordEncoder
    public List<UserDTO> findAll() {
        return userDAO.findAll().stream()
                .map(EntityDTOMapper::toUserDTO)
                .collect(Collectors.toList());
    }

    public Optional<UserDTO> findById(Long id) {
        return userDAO.findById(id)
                .map(EntityDTOMapper::toUserDTO);
    }

    public Optional<User> findEntityById(Long id) {
        return userDAO.findById(id);
    }

    public User updateUser(User user) {
        return userDAO.findById(user.getId())
                .map(existingUser -> {
                    existingUser.setName(user.getName());
                    existingUser.setAccount(user.getAccount());

                    // TODO: 未來改成只在 password 有變更時才重新加密
                    existingUser.setPassword(user.getPassword());

                    return userDAO.save(existingUser);
                })
                .orElseThrow(() -> new RuntimeException("User not found with id: " + user.getId()));
    }

    public User createUser(User user) {
        // TODO: 未來必須在此處實作密碼加密！
        // String encodedPassword = passwordEncoder.encode(user.getPassword());
        // user.setPassword(encodedPassword);

        // 目前直接儲存原始密碼
        return userDAO.save(user);
    }

    public void deleteById(Long id) {
        userDAO.deleteById(id);
    }
}
