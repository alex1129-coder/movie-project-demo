<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    com.aaj.movie.allan.entity.Users loginUser = (com.aaj.movie.allan.entity.Users) session.getAttribute("loginUser");
    String name = loginUser != null ? loginUser.getName() : "訪客";
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員中心 - 文暨電影院</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/frontend/css/index-beautified.css">
    <style>
        .menu-box {
            border: 3px solid #000;
            box-shadow: 8px 8px 0 #000;
            border-radius: 0;
            background-color: #fff;
            padding: 2rem;
            margin-top: 3rem;
        }
        .menu-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .menu-button {
            display: block;
            width: 100%;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            font-weight: bold;
            color: #000;
            background-color: #ffc107;
            border: 3px solid #000;
            box-shadow: 6px 6px 0 #000;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .menu-button:hover {
            background-color: #e0a800;
            color: #000;
            box-shadow: 3px 3px 0 #000;
            transform: translate(3px, 3px);
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
                                    <a href="checkmovie" class="nav-link">購票</a>
                                </li>
                                <li class="nav-item">
                                    <a href="member_menu" class="nav-link">Hi, ${sessionScope.loginUser.name}!</a>
                                </li>
                                <li class="nav-item">
                                    <a href="/logout" class="nav-link">登出</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a href="login" class="nav-link">購票</a>
                                </li>
                                <li class="nav-item">
                                    <a href="login" class="nav-link">登入</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- /.navbar -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="content">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="menu-box">
                                <div class="menu-header">
                                    <h2>Hi, <%= name %>!</h2>
                                    <p>歡迎來到會員中心，請選擇您需要的服務。</p>
                                </div>
                                <a href="checkmovie" class="menu-button">🎬 立即購票</a>
                                <a href="select_order" class="menu-button">📄 查詢訂單</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <footer class="main-footer">
            <div class="float-right d-none d-sm-inline">
                Anything you want
            </div>
            <strong>Copyright &copy; 2025 <a href="">aaj</a>.</strong> All rights reserved.
        </footer>
    </div>
    <!-- ./wrapper -->

    <!-- REQUIRED SCRIPTS -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>