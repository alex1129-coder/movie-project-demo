package com.aaj.movie.johnny.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.aaj.movie.allan.entity.Users;
import com.aaj.movie.entity.Movie;
import com.aaj.movie.entity.Showtime;
import com.aaj.movie.entity.Ticket;
import com.aaj.movie.johnny.repository.MovieRepository;
import com.aaj.movie.johnny.repository.ShowtimeRepository;
import com.aaj.movie.johnny.repository.TicketRepository;
import com.aaj.movie.johnny.repository.UserOrderRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class MovieController {

    @Autowired
    private MovieRepository movieRepository;
    @Autowired
    private ShowtimeRepository showtimeRepository;
    @Autowired
    private UserOrderRepository userOrderRepository;
    @Autowired
    private TicketRepository ticketRepository;

    @GetMapping("/member_menu")
    public String memberMenu(HttpSession session, Model model) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser != null) {
            model.addAttribute("name", loginUser.getName());
        } else {
            model.addAttribute("name", "訪客");
        }
        return "frontend/member_menu"; // 對應 member_menu.jsp
    }

    // 確認電影
    @GetMapping("/checkmovie")
    public String selectMovie(Model model) {
        List<Movie> movies = movieRepository.findAll();
        Map<Long, Boolean> movieHasAvailableSeats = new HashMap<>();

        int totalSeats = 24;

        for (Movie m : movies) {
            List<Showtime> showtimes = showtimeRepository.findByMovieId(m.getId());
            boolean hasAvailable = false;
            for (Showtime s : showtimes) {
                int soldCount = ticketRepository.findByShowtimeId(s.getId()).size();
                int available = totalSeats - soldCount;
                if (available > 0) {
                    hasAvailable = true;
                    break;
                }
            }
            movieHasAvailableSeats.put(m.getId(), hasAvailable);
        }

        model.addAttribute("movies", movies);
        model.addAttribute("movieHasAvailableSeats", movieHasAvailableSeats);

        return "frontend/checkmovie";
    }

    // 確認場次
    @GetMapping("/checkmovie/{id}")
    public String selectTime(@PathVariable("id") Long movieId, Model model) {
        Movie movie = movieRepository.findById(movieId).orElse(null);
        List<Showtime> showtimes = showtimeRepository.findByMovieId(movieId);

        int totalSeats = 24; // 每場最大座位數

        // 計算每個場次剩餘座位
        Map<Long, Integer> availableSeatsMap = new HashMap<>();
        for (Showtime s : showtimes) {
            // 查詢這個場次已售出的票數
            List<Ticket> soldTickets = ticketRepository.findByShowtimeId(s.getId());
            int availableSeats = totalSeats - soldTickets.size();
            if (availableSeats < 0) {
                availableSeats = 0; // 全滿就設 0
            }
            availableSeatsMap.put(s.getId(), availableSeats);
        }

        model.addAttribute("selectedMovie", movie);
        model.addAttribute("showtimes", showtimes);
        model.addAttribute("availableSeatsMap", availableSeatsMap);

        return "frontend/checkmovie_time";
    }

    @GetMapping("/checknumber/{showtimeId}")
    public String checkNumber(@PathVariable Long showtimeId, Model model) {
        Showtime showtime = showtimeRepository.findById(showtimeId).orElse(null);
        if (showtime == null) {
            return "redirect:/"; // 找不到場次，返回首頁
        }

        // 取得已售出的票
        List<Ticket> soldTickets = ticketRepository.findByShowtimeId(showtimeId);

        // 計算剩餘可選人數
        int totalSeats = 24; // 最大人數 24
        int soldCount = soldTickets.size();
        int availableSeats = totalSeats - soldCount;
        if (availableSeats < 1) {
            availableSeats = 0; // 如果全滿
        }
        // 將售出的座位轉成前端格式
        List<String> soldSeats = soldTickets.stream()
                .map(ticket -> ticket.getSeat().getSeatRow() + "-" + ticket.getSeat().getNumber())
                .collect(Collectors.toList());

        System.out.println("售出座位: " + soldSeats);
        System.out.println("剩餘可選人數: " + availableSeats);

        model.addAttribute("showtime", showtime);
        model.addAttribute("soldSeats", soldSeats);
        model.addAttribute("availableSeats", availableSeats);

        return "frontend/checkmovie_people";
    }

    //選位子
    @GetMapping("/seats")
    public String showSeats(@RequestParam Long showtimeId,
            @RequestParam(required = false, defaultValue = "1") Integer people,
            Model model) {
        // 驗證參數
        if (people == null || people < 1 || people > 24) {
            people = 1; // 設定預設值
        }

        Showtime showtime = showtimeRepository.findById(showtimeId).orElse(null);
        if (showtime == null) {
            // 如果場次不存在，重導到首頁
            return "redirect:/";
        }

        // 查出該場次已售出的座位
        List<Ticket> soldTickets = ticketRepository.findByShowtimeId(showtimeId);

        // 將座位轉成前端需要的格式 "A-1"
        List<String> soldSeats = soldTickets.stream()
                .map(ticket -> ticket.getSeat().getSeatRow() + "-" + ticket.getSeat().getNumber())
                .collect(Collectors.toList());
        System.out.println("售出座位" + soldSeats);

        model.addAttribute("showtime", showtime);
        model.addAttribute("people", people); // 傳到 JSP
        model.addAttribute("soldSeats", soldSeats); // 傳已售座位

        return "frontend/seats";
    }

    @GetMapping("/checkorder")
    public String showOrder(@RequestParam Long showtimeId,
            @RequestParam(required = false, defaultValue = "1") Integer people,
            @RequestParam(required = false, defaultValue = "[]") String seats,
            Model model,
            HttpSession session) {

        // 驗證參數
        if (people == null || people < 1 || people > 24) {
            people = 1;
        }

        Showtime showtime = showtimeRepository.findById(showtimeId).orElse(null);
        if (showtime == null) {
            return "redirect:/";
        }

        ObjectMapper objectMapper = new ObjectMapper();
        List<String> selectedSeats = new ArrayList<>();

        try {
            String[] seatsArray = objectMapper.readValue(seats, String[].class);
            selectedSeats = Arrays.asList(seatsArray);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 拆解 row 和 number
        List<String> rowList = new ArrayList<>();
        List<String> numberList = new ArrayList<>();
        for (String seat : selectedSeats) {
            if (seat != null && seat.contains("-")) {
                String[] parts = seat.split("-");
                rowList.add(parts[0]);
                numberList.add(parts[1]);
            } else {
                rowList.add("");
                numberList.add("");
            }
        }

        model.addAttribute("showtime", showtime);
        model.addAttribute("people", people);
        model.addAttribute("selectedSeats", selectedSeats);

        //資料庫獲取座位資料
        model.addAttribute("rowList", rowList);
        model.addAttribute("numberList", numberList);

        // 取得登入會員姓名
        Users loginUser = (Users) session.getAttribute("loginUser");
        String customerName = loginUser != null ? loginUser.getName() : "訪客";

        //資料庫獲取名稱
        String orderId = generate(); // Use the service to generate order number
        model.addAttribute("orderId", orderId);
        model.addAttribute("customerName", customerName); // <-- 使用登入姓名
        model.addAttribute("totalAmount", people * 300); // 假設每張票 300
        model.addAttribute("orderStatus", "待付款");
        model.addAttribute("orderDate", LocalDateTime.now().toString());

        // ...原本的座位拆解、計算總金額等邏輯...
        Map<String, Object> orderInfo = new HashMap<>();
        orderInfo.put("rowList", rowList);
        orderInfo.put("numberList", numberList);

        orderInfo.put("showtime", showtime);
        orderInfo.put("people", people);
        orderInfo.put("selectedSeats", selectedSeats);
        orderInfo.put("orderId", orderId);
        orderInfo.put("customerName", customerName);
        orderInfo.put("totalAmount", people * 300);
        orderInfo.put("orderStatus", "待付款");
        orderInfo.put("orderStatus_backend", "PENDING");
        orderInfo.put("orderDate", LocalDateTime.now());

        session.setAttribute("orderInfo", orderInfo);

        // 加入 Model 顯示在 checkorder.jsp
        model.addAllAttributes(orderInfo);

        return "frontend/checkorder";
    }

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");

    public String generate() {
        String timestamp = formatter.format(LocalDateTime.now());
        int randomSuffix = (int) (Math.random() * 1000);
        // Return order number with "ORD" prefix and zero-padded random number
        return String.format("ORD%s%03d", timestamp, randomSuffix);
    }

}
