package com.aaj.movie.allan.Repository;
/*
 * why 不放在 dao資料夾?
 * 因為這是 Spring Data JPA 的 Repository 介面，通常會放在 repository 資料夾中，以區別於傳統的 DAO 介面
 * 這樣的結構有助於組織和維護程式碼，讓開發者更容易找到和管理不同類型的資料存取物件
 * OrderRepository 是「Repository Pattern」的介面（通常 extends JpaRepository），
 * 而 DAO 較偏向你自己寫 SQL/JdbcTemplate 的那層。
 * 為了讓讀程式的人一眼懂，你用 JPA 就放 repository；用手寫 SQL/ MyBatis 就放 dao/mapper。
 */

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.aaj.movie.entity.Order;

//訂單的資料存取物件(DAO)類別
//@Repository 註解在 Spring Data 介面上可有可無（Boot 會自動套上並做例外轉換）。留下也無妨，更顯式
@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
  Optional<Order> findByOrderNumber(String orderNumber);
  Optional<Order> findByLinepayTransactionId(String linepayTransactionId);

  /// 用「帳號」找所有訂單，並且一次把「票券、場次、電影」抓過來（避免慢吞吞的 N+1）
    @Query("""
        select distinct o from Order o
          join o.user u
          left join fetch o.tickets t
          left join fetch t.showtime s
          left join fetch s.movie m
        where lower(u.account) = lower(:account)
        order by o.orderId desc
    """)
    List<Order> findAllWithTicketsByUserAccountIgnoreCase(@Param("account") String account);

    // 用「userId」找自己的所有訂單，同樣一次抓齊需要的資料
    @Query("""
        select distinct o from Order o
          join o.user u
          left join fetch o.tickets t
          left join fetch t.showtime s
          left join fetch s.movie m
        where u.id = :userId
        order by o.orderId desc
    """)
    List<Order> findAllWithTicketsByUserId(@Param("userId") Long userId);
}
