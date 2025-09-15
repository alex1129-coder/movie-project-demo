package com.aaj.movie.johnny.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.OrderStatus;
import com.aaj.movie.entity.Seat;
import com.aaj.movie.entity.Showtime;
import com.aaj.movie.entity.Ticket;
import com.aaj.movie.entity.User;
import com.aaj.movie.johnny.repository.SeatRepository;
import com.aaj.movie.johnny.repository.ShowtimeRepository;
import com.aaj.movie.johnny.repository.TicketRepository;
import com.aaj.movie.johnny.repository.UserOrderRepository;
import com.aaj.movie.johnny.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

    @Autowired
    private UserOrderRepository userOrderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private ShowtimeRepository showtimeRepository;

    @GetMapping("/finish_order")
    public String finishOrder(HttpSession session, Model model) {
        @SuppressWarnings("unchecked")
        Map<String, Object> orderInfo = (Map<String, Object>) session.getAttribute("orderInfo");
        if (orderInfo == null) {
            return "redirect:/"; // 如果沒有資料，導回首頁
        }

        //order
        if (orderInfo != null) {
            // 從 DB 撈出 User
            Long loginUserid = (Long) session.getAttribute("loginUserid");
            User user = userRepository.findById(loginUserid)
                    .orElseThrow(() -> new RuntimeException("User not found"));

            // 建立訂單
            Order order = new Order();
            order.setOrderNumber((String) orderInfo.get("orderId"));
            order.setTotalAmount(new BigDecimal(orderInfo.get("totalAmount").toString()));
            order.setStatus(OrderStatus.valueOf(orderInfo.get("orderStatus_backend").toString()));
            order.setLinepayTransactionId((String) orderInfo.get("transactionId"));
            order.setUser(user);

            // 存進資料庫
            userOrderRepository.save(order);
            model.addAttribute("order", order);

            Showtime showtime = (Showtime) orderInfo.get("showtime");
            if (showtime == null) {
                throw new RuntimeException("Showtime 資料缺失");
            }

            @SuppressWarnings("unchecked")
            List<String> rowList = (List<String>) orderInfo.get("rowList");
            @SuppressWarnings("unchecked")
            List<String> numberListStr = (List<String>) orderInfo.get("numberList");

            // 將字符串列表轉換為整數列表
            List<Integer> numberList = numberListStr.stream()
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            for (int i = 0; i < rowList.size(); i++) {
                Seat seat = seatRepository.findBySeatRowAndNumber(rowList.get(i), numberList.get(i))
                        .orElseThrow(() -> new RuntimeException("Seat not found"));
                Ticket ticket = new Ticket(order, seat, showtime);
                ticketRepository.save(ticket);
            }

        }

        System.out.println("完成頁第幾排: " + orderInfo.get("rowList"));
        System.out.println("完成頁第幾行: " + orderInfo.get("numberList"));

        // 放回 Model 顯示 finish_order.jsp
        model.addAllAttributes(orderInfo);

        // 可選：送出後清除 Session
        session.removeAttribute("orderInfo");

        return "frontend/finish_order";
    }

}
