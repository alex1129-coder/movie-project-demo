<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>非會員查詢訂單 - 文暨電影院</title>
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

        .query-section {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #f8f9fa;
        }
        .query-section h3 {
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            font-weight: bold;
            color: #343a40;
            margin-bottom: 0.5rem;
            display: block;
            font-size: 1.1rem;
        }
        .form-control-custom {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 2px solid #000;
            background-color: #fff;
            box-shadow: 2px 2px 0 #000;
        }
        .form-control-custom:focus {
            outline: none;
            box-shadow: 4px 4px 0 #000;
        }

        .error-message {
            background-color: #f8d7da;
            border: 2px solid #dc3545;
            color: #721c24;
            padding: 1rem;
            margin-top: 1rem;
            font-weight: bold;
        }

        .results-section {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #f8f9fa;
        }
        .results-section h3 {
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }
        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            border: 2px solid #000;
            box-shadow: 4px 4px 0 #000;
        }
        .results-table th,
        .results-table td {
            border: 1px solid #000;
            padding: 0.75rem;
            text-align: left;
        }
        .results-table th {
            background-color: #343a40;
            color: white;
            font-weight: bold;
            text-align: center;
        }
        .results-table td {
            background-color: #fff;
        }
        .results-table tr:nth-child(even) td {
            background-color: #f8f9fa;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
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
        }
        .action-btn:hover { 
            box-shadow: 3px 3px 0 #000; 
            transform: translate(3px, 3px); 
            text-decoration: none;
        }
        .action-btn.primary {
            background-color: #28a745;
            color: white;
        }
        .action-btn.primary:hover {
            background-color: #218838;
            color: white;
        }
        .action-btn.secondary {
            background-color: #007bff;
            color: white;
        }
        .action-btn.secondary:hover {
            background-color: #0056b3;
            color: white;
        }

        .bottom-actions {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
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
                                    <h2>非會員查詢訂單</h2>
                                </div>

                                <div class="query-section">
                                    <h3><i class="fas fa-search"></i> 訂單查詢</h3>
                                    
                                    <form method="post" action="${pageContext.request.contextPath}/select_order_non_member">
                                        <div class="form-group">
                                            <label for="account">
                                                <i class="fas fa-user"></i> 會員帳號
                                            </label>
                                            <input type="text" 
                                                   id="account"
                                                   name="account" 
                                                   class="form-control-custom"
                                                   value="${param.account}" 
                                                   required 
                                                   placeholder="請輸入會員帳號">
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <button type="submit" class="action-btn primary">
                                                <i class="fas fa-search"></i> 查詢
                                            </button>
                                        </div>
                                    </form>

                                    <c:if test="${not empty errorMsg}">
                                        <div class="error-message">
                                            <i class="fas fa-exclamation-triangle"></i> ${errorMsg}
                                        </div>
                                    </c:if>
                                </div>

                                <!-- 查詢結果 -->
                                <c:if test="${not empty rows}">
                                    <div class="results-section">
                                        <h3><i class="fas fa-list"></i> 查詢結果</h3>
                                        
                                        <table class="results-table">
                                            <thead>
                                                <tr>
                                                    <th><i class="fas fa-film"></i> 電影</th>
                                                    <th><i class="fas fa-clock"></i> 場次時間</th>
                                                    <th><i class="fas fa-chair"></i> 座位</th>
                                                    <th><i class="fas fa-dollar-sign"></i> 總金額 (TWD)</th>
                                                    <th><i class="fas fa-info-circle"></i> 訂單狀態</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="r" items="${rows}">
                                                    <tr>
                                                        <td>${r.movieTitle}</td>
                                                        <td><fmt:formatDate value="${r.showtime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                        <td>${r.seats}</td>
                                                        <td><fmt:formatNumber value="${r.totalAmount}" maxFractionDigits="0"/></td>
                                                        <td>${r.status}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>

                                <div class="bottom-actions">
                                    <form action="login" style="display: contents;">
                                        <button class="action-btn secondary">
                                            <i class="fas fa-arrow-left"></i> 回上頁
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