package com.aaj.movie.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaj.movie.backend.dao.OrderDAO;
import com.aaj.movie.backend.dto.OrderDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.OrderStatus;

@Service
public class OrderService {

    @Autowired
    private OrderDAO orderDAO;

    public List<OrderDTO> findAll() {
        return orderDAO.findAll().stream()
                .map(EntityDTOMapper::toOrderDTO)
                .collect(Collectors.toList());
    }

    public Optional<OrderDTO> findById(Long id) {
        return orderDAO.findById(id)
                .map(EntityDTOMapper::toOrderDTO);
    }

    // 未來可以繼續在這裡新增其他方法，例如更新訂單狀態等
    public Optional<OrderDTO> updateOrderStatus(Long orderId, String newStatus) {
        // 1. 從資料庫找出訂單實體
        Optional<Order> optionalOrder = orderDAO.findById(orderId);

        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();

            // 2. 將傳入的 String 轉為 OrderStatus enum
            try {
                OrderStatus statusEnum = OrderStatus.valueOf(newStatus.toUpperCase());
                order.setStatus(statusEnum);
            } catch (IllegalArgumentException e) {
                // 如果傳入的狀態字串無效，可以選擇拋出錯誤或直接返回空 Optional
                System.err.println("無效的訂單狀態: " + newStatus);
                return Optional.empty();
            }

            // 3. 儲存更新後的訂單
            Order updatedOrder = orderDAO.save(order);

            // 4. 將更新後的實體轉為 DTO 並返回
            return Optional.of(EntityDTOMapper.toOrderDTO(updatedOrder));
        } else {
            // 如果找不到訂單，返回空的 Optional
            return Optional.empty();
        }
    }
}
