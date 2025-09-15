package com.aaj.movie.backend.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aaj.movie.backend.dto.OrderDTO;
import com.aaj.movie.backend.service.OrderService;

@RestController
@RequestMapping("/admin/api/orders")
public class adminOrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public List<OrderDTO> getAllOrders() {
        return orderService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTO> getOrderById(@PathVariable Long id) {
        return orderService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    public ResponseEntity<OrderDTO> updateOrderStatus(
            @PathVariable Long id,
            @RequestBody Map<String, String> statusUpdate) {
        // 從傳入的 JSON 中取出 "status" 的值
        String newStatus = statusUpdate.get("status");
        if (newStatus == null || newStatus.trim().isEmpty()) {
            return ResponseEntity.badRequest().build(); // 如果請求格式不對，返回 400 Bad Request
        }
        Optional<OrderDTO> updatedOrder = orderService.updateOrderStatus(id, newStatus);

        return updatedOrder
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build()); // 如果找不到訂單，返回 404 Not Found

    }

}
