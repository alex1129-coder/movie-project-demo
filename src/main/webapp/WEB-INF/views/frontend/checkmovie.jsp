<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>選擇電影 - 文暨電影院</title>
    <!-- AdminLTE CSS -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/frontend/css/index-beautified.css">
    <style>
        .booking-container {
            border: 3px solid #000;
            box-shadow: 8px 8px 0 #000;
            border-radius: 0;
            background-color: #fff;
            padding: 2rem;
            margin-top: 3rem;
        }
        .booking-header {
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 3px solid #000;
            padding-bottom: 1.5rem;
        }
        .form-control-lg {
            border-width: 3px;
            border-radius: 0;
            border-color: #000;
            font-size: 1.5rem;
            font-weight: bold;
            padding: 1rem;
            height: auto;
        }
        .submit-button {
            display: block;
            width: 100%;
            padding: 1.2rem;
            margin-top: 2rem;
            font-size: 1.8rem;
            font-weight: bold;
            color: #000;
            background-color: #ffc107;
            border: 3px solid #000;
            box-shadow: 6px 6px 0 #000;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .submit-button:hover {
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
        <!-- /.navbar -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="content">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="booking-container">
                                <div class="booking-header">
                                    <h2>Step 1: 選擇電影</h2>
                                    <p>請從下拉選單中選擇您想看的電影。</p>
                                </div>
                                <form id="movie-select-form">
                                    <div class="form-group">
                                        <select id="movie-select" class="form-control form-control-lg">
                                            <option value="" disabled selected>--- 請選擇一部電影 ---</option>
                                            <c:forEach var="m" items="${movies}">
                                            <c:choose>
                                                <c:when test="${movieHasAvailableSeats[m.id]}">
                                                    <option value="${m.id}">${m.title}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="" disabled>${m.title} (已售完)</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="submit-button">下一步：選擇場次</button>
                                </form>
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
    <script>
        $(document).ready(function() {
            $('#movie-select-form').submit(function(e) {
                e.preventDefault();
                var movieId = $('#movie-select').val();
                if (movieId) {
                    window.location.href = '/checkmovie/' + movieId;
                } else {
                    alert('請先選擇一部電影！');
                }
            });
        });
    </script>
</body>
</html>




                                