<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文暨電影院</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/frontend/css/index-beautified.css">
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
                    <!-- Left navbar links -->
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
            <!-- Main content -->
            <div class="content">
                <div class="container">
                    <!-- Welcome message if logged in -->
                    <c:if test="${not empty sessionScope.loginUser and not empty param.login_success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>登入成功!</strong> 歡迎回來, ${sessionScope.loginUser.name}!
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- 電影卡片 -->
                    <section class="movie-container" id="browse"></section>

                    <!-- 分頁 -->
                    <div class="pagination" id="pagination"></div>
                </div><!-- /.container-fluid -->
            </div>
            <!-- /.content -->
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
    <!-- jQuery -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="/frontend/js/index.js"></script>
</body>

</html>