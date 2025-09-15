package com.aaj.movie.allan.service;

// 這個服務負責「查詢訂單」的邏輯，會員/非會員都會用到它。
// 解釋：把很多資料庫資料，整理成我們想顯示的一列一列資訊，給頁面使用。

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Optional; // ← 你現有的 Repository 路徑
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.aaj.movie.allan.Repository.OrderRepository;
import com.aaj.movie.allan.dto.OrderSummaryRow;
import com.aaj.movie.entity.Order;
import com.aaj.movie.entity.Seat;
import com.aaj.movie.entity.Ticket;

import jakarta.transaction.Transactional;

@Service
@Transactional(Transactional.TxType.SUPPORTS) // 小學生版：這裡只讀資料，不會改資料
public class OrderQueryService {

    private final OrderRepository orderRepository;

    public OrderQueryService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    /** 非會員查詢：用「帳號」找訂單清單，並整理成畫面要的一列一列 */
    public List<OrderSummaryRow> findSummariesByAccount(String account) {
        // 一次抓齊 訂單+票券+座位+場次+電影（已在 Repository 用 fetch join 寫好）
        List<Order> orders = orderRepository.findAllWithTicketsByUserAccountIgnoreCase(account);
        return toSummaryRows(orders);
    }

    /** 會員查詢：用「userId」找自己的所有訂單 */
    public List<OrderSummaryRow> findSummariesByUserId(Long userId) {
        List<Order> orders = orderRepository.findAllWithTicketsByUserId(userId);
        return toSummaryRows(orders);
    }

    /** 把多筆訂單 → 變成畫面好讀的「摘要列」 */
    private List<OrderSummaryRow> toSummaryRows(List<Order> orders) {
        if (orders == null || orders.isEmpty()) return List.of();

        return orders.stream().map(o -> {
            // 小朋友懂的說法：一張訂單會有好幾張票，我們拿「第一張票」來當代表
            // 因為同一張訂單的票，通常都是同一個場次、同一部電影
            Ticket firstTicket = Optional.ofNullable(o.getTickets())
                    .flatMap(list -> list.stream().findFirst())
                    .orElse(null);

            // 1) 電影名稱：ticket.showtime.movie.title
            String movieTitle = "(未找到電影)";
            if (firstTicket != null && firstTicket.getShowtime() != null
                    && firstTicket.getShowtime().getMovie() != null
                    && firstTicket.getShowtime().getMovie().getTitle() != null) {
                movieTitle = firstTicket.getShowtime().getMovie().getTitle();
            }

            // 2) 場次時間：LocalDateTime → java.util.Date（JSP 的 <fmt:formatDate/> 比較愛用 Date）
            Date showtimeDate = null;
            if (firstTicket != null && firstTicket.getShowtime() != null) {
                LocalDateTime ldt = firstTicket.getShowtime().getStartTime();
                if (ldt != null) {
                    showtimeDate = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
                }
            }

            // 3) 座位清單：把所有票的座位接成字串，例如 "A5, A6, A7"
            String seatsStr = Optional.ofNullable(o.getTickets()).orElseGet(List::of).stream()
                    .sorted(Comparator.comparing(Ticket::getId)) // 排一下，畫面更整齊
                    .map(Ticket::getSeat)                        // 取出每張票的座位
                    .map(this::seatLabel)                        // 轉成像 A5 這樣的文字
                    .filter(s -> !s.isBlank())
                    .collect(Collectors.joining(", "));

            // 4) 總金額與狀態：直接用訂單上的欄位
            BigDecimal total = Optional.ofNullable(o.getTotalAmount()).orElse(BigDecimal.ZERO);

            return new OrderSummaryRow(
                    movieTitle,
                    showtimeDate,
                    seatsStr,
                    total,
                    o.getStatus()
            );
        }).toList();
    }

    /** 把座位做成「A5」這樣的字：row(字母) + number(數字) */
    private String seatLabel(Seat seat) {
        if (seat == null) return "";
        String row = seat.getSeatRow();     // 例如 "A"
        Integer num = seat.getNumber();     // 例如 5
        if (row == null || num == null) return "";
        return row + num;                   // "A" + 5 → "A5"
    }
}
