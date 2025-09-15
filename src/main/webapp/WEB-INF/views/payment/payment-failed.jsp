<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>付款失敗 - 文暨電影院</title>
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

        .failed-indicator {
            text-align: center;
            padding: 1rem;
            background-color: #f8d7da;
            border: 3px solid #721c24;
            margin-bottom: 2rem;
            color: #721c24;
        }
        .failed-indicator i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #dc3545;
        }
        .failed-indicator h4 {
            font-size: 1.5rem;
            font-weight: bold;
            margin: 0;
        }

        .payment-details {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #f8f9fa;
        }
        .payment-details h3 {
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }
        .payment-details p {
            font-size: 1.1rem;
            margin-bottom: 0.75rem;
        }
        .payment-details strong {
            font-weight: bold;
            color: #343a40;
        }
        .error-message {
            background-color: #f8d7da;
            border: 2px solid #dc3545;
            color: #721c24;
            padding: 1rem;
            margin-top: 1rem;
            font-weight: bold;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
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
        .action-btn.secondary {
            background-color: #6c757d;
        }
        .action-btn.secondary:hover {
            background-color: #545b62;
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
                                    <h2>付款結果</h2>
                                </div>

                                <div class="failed-indicator">
                                    <i class="fas fa-times-circle"></i>
                                    <h4>付款未完成</h4>
                                </div>

                                <div class="payment-details">
                                    <h3>訂單資訊</h3>
                                    <p><strong>訂單編號：</strong>
                                        <c:out value="${orderNumber}" default="${param.orderId}" />
                                    </p>
                                    
                                    <c:if test="${not empty errorMessage}">
                                        <div class="error-message">
                                            <strong>失敗原因：</strong><c:out value="${errorMessage}"/>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/orders/detail?orderNumber=<c:out value='${orderNumber}' default='${param.orderId}'/>" 
                                       class="action-btn">查看訂單</a>
                                    <a href="${pageContext.request.contextPath}/product/prod" 
                                       class="action-btn secondary">回商品頁</a>
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