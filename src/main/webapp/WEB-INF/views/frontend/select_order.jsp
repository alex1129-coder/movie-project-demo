<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員訂單查詢 - 文暨電影院</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/frontend/css/index-beautified.css">
    <style>
        .booking-container {
            border: 3px solid #000;
            box-shadow: 8px 8px 0 #000;
            border-radius: 0;
            background-color: #fff;
            padding: 2rem;
            margin-top: 2rem;
        }
        .booking-header {
            text-align: center;
            margin-bottom: 1rem;
            border-bottom: 3px solid #000;
            padding-bottom: 1rem;
        }

        .welcome-section {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #e3f2fd;
            text-align: center;
        }
        .welcome-section h3 {
            font-size: 1.3rem;
            font-weight: bold;
            color: #1976d2;
            margin-bottom: 0.5rem;
        }
        .welcome-section h4 {
            font-size: 1.1rem;
            color: #424242;
            margin: 0;
        }

        .orders-section {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #f8f9fa;
        }
        .orders-section h3 {
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .order-card {
            border: 2px solid #000;
            margin-bottom: 1.5rem;
            background-color: #fff;
            box-shadow: 4px 4px 0 #000;
        }
        .order-card-header {
            background-color: #007bff;
            color: white;
            padding: 0.75rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
        }
        .order-card-body {
            padding: 1.5rem;
        }
        .order-detail {
            display: flex;
            margin-bottom: 0.75rem;
            align-items: center;
        }
        .order-detail i {
            font-size: 1.2rem;
            margin-right: 0.75rem;
            color: #6c757d;
            width: 20px;
            text-align: center;
        }
        .order-label {
            font-weight: bold;
            color: #343a40;
            min-width: 120px;
            margin-right: 0.5rem;
        }
        .order-value {
            color: #495057;
            font-size: 1rem;
        }
        .order-value.amount {
            font-weight: bold;
            color: #28a745;
            font-size: 1.1rem;
        }
        .order-value.status {
            font-weight: bold;
            padding: 0.25rem 0.75rem;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .order-value.status.completed {
            background-color: #d4edda;
            color: #155724;
        }
        .order-value.status.pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .no-orders {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
            font-style: italic;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }
        .action-btn {
            padding: 1rem 2rem;
            font-size: 1.3rem;
            font-weight: bold;
            border: 3px solid #000;
            box-shadow: 6px 6px 0 #000;
            transition: all 0.2s ease;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            background-color: #007bff;
            color: white;
        }
        .action-btn:hover { 
            box-shadow: 3px 3px 0 #000; 
            transform: translate(3px, 3px); 
            text-decoration: none;
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>

<body class="hold-transition layout-top-nav">
    <div class="wrapper">
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
            <div class="container">
                <a href="/" class="navbar-brand">
                    <span class="brand-text font-weight-light"><h1>文暨電影院</h1></span>
                </a>
                <div class="collapse navbar-collapse order-3" id="navbarCollapse">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a href="/#browse" class="nav-link">電影</a>
                        </li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.loginUser}">
                                <li class="nav-item">
                                    <a href="/checkmovie" class="nav-link">購票</a>
                                </li>
                                <li class="nav-item">
                                    <a href="/member_menu" class="nav-link">Hi, ${sessionScope.loginUser.name}!</a>
                                </li>
                                <li class="nav-item">
                                    <a href="/logout" class="nav-link">登出</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a href="/login" class="nav-link">購票</a>
                                </li>
                                <li class="nav-item">
                                    <a href="/login" class="nav-link">登入</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <div class="content">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-10 col-xl-8">
                            <div class="booking-container">
                                <div class="booking-header">
                                    <h2>會員訂單查詢</h2>
                                </div>

                                <div class="welcome-section">
                                    <h3><i class="fas fa-user-circle"></i> Hi~ 親愛的會員 <c:out value="${memberName}"/> 您好</h3>
                                    <h4>以下是您的訂單詳情</h4>
                                </div>

                                <div class="orders-section">
                                    <h3><i class="fas fa-ticket-alt"></i> 您的訂單</h3>
                                    
                                    <!-- 如果沒有任何訂單 -->
                                    <c:if test="${empty rows}">
                                        <div class="no-orders">
                                            <i class="fas fa-inbox fa-3x mb-3 text-muted"></i>
                                            <p>目前沒有任何訂單喔！</p>
                                        </div>
                                    </c:if>

                                    <!-- 有訂單就一筆一筆列出來 -->
                                    <c:forEach var="r" items="${rows}" varStatus="st">
                                        <div class="order-card">
                                            <div class="order-card-header">
                                                <i class="fas fa-receipt"></i> 訂單 #${st.count}
                                            </div>
                                            <div class="order-card-body">
                                                <div class="order-detail">
                                                    <i class="fas fa-film"></i>
                                                    <span class="order-label">電影：</span>
                                                    <span class="order-value">${r.movieTitle}</span>
                                                </div>
                                                <div class="order-detail">
                                                    <i class="fas fa-clock"></i>
                                                    <span class="order-label">場次時間：</span>
                                                    <span class="order-value">
                                                        <fmt:formatDate value="${r.showtime}" pattern="yyyy-MM-dd HH:mm"/>
                                                    </span>
                                                </div>
                                                <div class="order-detail">
                                                    <i class="fas fa-chair"></i>
                                                    <span class="order-label">座位：</span>
                                                    <span class="order-value">${r.seats}</span>
                                                </div>
                                                <div class="order-detail">
                                                    <i class="fas fa-dollar-sign"></i>
                                                    <span class="order-label">總金額：</span>
                                                    <span class="order-value amount">
                                                        NT$ <fmt:formatNumber value="${r.totalAmount}" maxFractionDigits="0"/>
                                                    </span>
                                                </div>
                                                <div class="order-detail">
                                                    <i class="fas fa-info-circle"></i>
                                                    <span class="order-label">訂單狀態：</span>
                                                    <span class="order-value status ${r.status == 'PENDING' ? 'pending':'completed' }">
                                                        ${r.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="action-buttons">
                                    <form action="${pageContext.request.contextPath}/member_menu" method="get" style="display: contents;">
                                        <button type="submit" class="action-btn">
                                            <i class="fas fa-home"></i> 回會員頁面
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                Anything you want
            </div>
            <strong>Copyright &copy; 2025 <a href="">aaj</a>.</strong> All rights reserved.
        </footer>
    </div>

    <!-- SCRIPTS -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>