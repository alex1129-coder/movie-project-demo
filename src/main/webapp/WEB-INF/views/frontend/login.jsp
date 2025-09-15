<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員登入 - 文暨電影院</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/frontend/css/index-beautified.css">
    <style>
        html, body {
            height: 100%;
        }
        .wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content-wrapper {
            flex: 1 0 auto; /* Let it grow and shrink */
            display: flex;
            align-items: center; /* Vertical centering */
            justify-content: center; /* Horizontal centering */
        }
        .wrapper .content-wrapper {
            /* min-height: calc(100vh - calc(3.5rem + 1px) - calc(3.5rem + 1px)); */
            min-height: 750px;
        }
        .main-footer {
            flex-shrink: 0; /* Prevent footer from shrinking */
        }
        .login-box {
            width: 100%;
            max-width: 500px; /* Control the max width */
            border: 3px solid #000;
            box-shadow: 8px 8px 0 #000;
            border-radius: 0;
        }
        .login-card-header {
            text-align: center;
            padding: 2rem;
            border-bottom: 3px solid #000;
        }
        .login-card-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: bold;
        }
        .login-card-body {
            padding: 2rem;
        }
        .btn-primary {
            background-color: #ffc107;
            border-color: #000;
            color: #000;
            font-weight: bold;
            border-width: 3px;
            border-radius: 0;
            box-shadow: 4px 4px 0 #000;
        }
        .btn-primary:hover {
            background-color: #e0a800;
            border-color: #000;
            color: #000;
        }
        .form-control {
            border-width: 3px;
            border-radius: 0;
            border-color: #000;
        }
        .error-msg {
            color: red;
            font-weight: bold;
            margin: 10px 0;
            text-align: center;
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
                        <li class="nav-item">
                            <a href="/select_order_non_member" class="nav-link">查詢訂單（非會員）</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- /.navbar -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="card login-box">
                <div class="card-header login-card-header">
                    <h1>會員登入</h1>
                </div>
                <div class="card-body login-card-body">
                    <!-- Error Message Block -->
                    <c:if test="${not empty errors}">
                        <div class="error-msg">
                            <c:forEach var="msg" items="${errors.values()}">
                                ${msg}<br/>
                            </c:forEach>
                        </div>
                    </c:if>
                    <!-- Form posts to /login (POST) -->
                    <form method="post" action="<c:url value='/login'/>">
                        <div class="form-group">
                            <label for="account">帳號</label>
                            <input type="text" id="account" name="account" class="form-control" placeholder="請輸入帳號" required>
                        </div>
                        <div class="form-group">
                            <label for="password">密碼</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="請輸入密碼" required>
                        </div>
                        <div class="form-group text-right">
                            <div>還沒有帳號? <a href="<c:url value='/register'/>">點我註冊</a></div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">登入</button>
                    </form>
                    <div class="note text-center mt-3">本網站不會主動與您聯繫索取個人資訊，請勿受騙。</div>
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
    <!-- jQuery -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
