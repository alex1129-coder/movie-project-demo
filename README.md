# 🎬 Movie Booking System

URL: 
https://movbooking.ddns.net/
https://movbooking.ddns.net/admin/login

A group project for building an online movie ticket booking system.  
Developed by:
- **PM**: Allan  
- **Full-stack Developer**: Alex（Me）  
- **Backend Developer**: Johnny  

---

## 👥 Contributions

### Alex (Full-stack Developer, Me)
- Developed the **admin management system**
- Implemented **admin login** with Spring Security  
- Designed and built the **frontend UI** (AdminLTE + Bootstrap + JSP)  
- Responsible for **final system integration and deployment**  

### Allan (PM)
- Project management & task coordination
- Integrated **LINE Pay** API for payments

### Johnny (Backend Developer)
- Implemented **core backend logic** (order, ticket, seat modules)  
- Designed **database schema** and data access layer  

---

## 📖 Project Overview
This project is a **movie booking system** that allows users to:
- Register and log in as members
- Browse available movies and showtimes
- Select seats and purchase tickets
- Complete payments via **LINE Pay（simulation）** integration

It also includes an admin interface.

---

## 🛠️ Tech Stack
- **Frontend**: JSP, Bootstrap, AdminLTE  
- **Backend**: Java 17, Spring Boot, Spring Security  
- **Database**: MariaDB (via JPA/Hibernate)  
- **Server**: Tomcat 10.1.43  
- **Build Tool**: Maven 3.9.11  
- **Payment Integration**: LINE Pay Sandbox  

---

## ✨ Features
### 👤 Member Side
- User registration & login
- Browse movies & showtimes
- Seat selection with availability check
- Ticket ordering and payment (LINE Pay)
- Order history & ticket details

### 🔧 Admin Side
- Admin login (Spring Security)
- Movie CRUD operations
- Manage users and showtimes
- View order statistics

---

## 📊 Database Design（JPA ORM Entity）
- **admins**: id, account, password
- **users**: id, name, account, password
- **movies**: id, title, director, rating（普遍級、保護級、限制級等）, subtitles（中文、英文、日文）, description, duration, premiere_date, poster_url
- **showtimes**: id, movie_id, start_time, price
- **seats**: id, row（A~D）, number（1~6）
- **orders**: order_id, order_number, user_id, total_amount, status (pending/paid/failed/canceled/refunded), linepay_transaction_id, created_at
- **tickets**: id, order_id, showtime_id, seat_id

---

## 📷 Screenshots


---

## 📌 Status
Project completed for course presentation on **2025/09/16**.

---

## 📄 License
This project is for educational purposes only.
