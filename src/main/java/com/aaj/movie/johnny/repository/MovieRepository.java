package com.aaj.movie.johnny.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Movie;

/**
 * 電影資料存取介面，繼承 JpaRepository
 * 可自動取得基本 CRUD 功能
 */
public interface MovieRepository extends JpaRepository<Movie, Long> {
	// 可自訂查詢方法
}
