package com.aaj.movie.allan.entity;
//會員的實體(entity)類別

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "users") // 對應資料庫的 users 資料表
public class Users {
	
        @Id // 這個欄位是「主鍵」（唯一的身分證號）
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private long id;
        
        @Column(name = "account")
        private String account;//帳號
            
        @Column(name = "password")
        private String password;//密碼
            
        @Column(name = "name")
        private String name;//會員姓名

        public long getId() {
                return id;
        }

        public void setId(long id) {
                this.id = id;
        }

        public String getAccount() {
                return account;
        }

        public void setAccount(String account) {
                this.account = account;
        }

        public String getPassword() {
                return password;
        }

        public void setPassword(String password) {
                this.password = password;
        }

        public String getName() {
                return name;
        }

        public void setName(String name) {
                this.name = name;
        }

        

}
