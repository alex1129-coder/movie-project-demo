package com.aaj.movie.allan.Repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.allan.entity.Users;

public interface UsersRepository extends JpaRepository<Users, Long> {
    // 可以額外加查詢方法，例如根據帳號查姓名
}
