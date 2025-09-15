//會員的資料存取物件(DAO)類別
// DAO (Data Access Object)
// 是資料存取物件，負責執行資料庫的 CRUD（建立、讀取、更新、刪除）操作，是業務邏輯層的組件
package com.aaj.movie.allan.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.aaj.movie.allan.entity.Users;

//extends JpaRepository<Users, Integer> 代表這個介面是針對 Users 這個實體類別進行資料存取，且主鍵的型別是 Integer
@Repository
public interface UsersDao extends JpaRepository<Users, Integer>{
    boolean existsByAccountIgnoreCase(String account); // 查詢是否存在指定帳號(不分大小寫)
    Optional<Users> findByAccountIgnoreCase(String account); // 根據帳號查詢會員(不分大小寫)
    Optional<Users> findByAccountIgnoreCaseAndPassword(String account, String password); // 帳密 明碼比對


}


