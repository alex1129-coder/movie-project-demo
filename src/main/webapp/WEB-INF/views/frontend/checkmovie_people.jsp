<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>選擇人數 - 文暨電影院</title>
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
            margin-top: 3rem;
        }
        .booking-header {
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 3px solid #000;
            padding-bottom: 1.5rem;
        }
        
        /* New Ticket Summary Styles */
        .ticket-summary {
            border: 3px solid #000;
            margin-bottom: 2.5rem;
            background-color: #f8f9fa;
        }
        .ticket-header {
            background-color: #000;
            color: #fff;
            padding: 0.5rem;
            text-align: center;
        }
        .ticket-header h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .ticket-body {
            display: flex;
            justify-content: space-around;
            padding: 1.5rem 1rem;
            text-align: center;
        }
        .ticket-section {
            flex: 1;
        }
        .ticket-section i {
            font-size: 2rem;
            margin-bottom: 0.75rem;
            color: #343a40;
        }
        .ticket-section h4 {
            font-size: 1rem;
            font-weight: normal;
            color: #6c757d;
            margin-bottom: 0.25rem;
            text-transform: uppercase;
        }
        .ticket-section p {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
            word-wrap: break-word;
        }

        .people-selector {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 2rem 0;
        }
        .people-btn {
            font-size: 2.5rem;
            font-weight: bold;
            padding: 0.5rem 1.5rem;
            cursor: pointer;
            background-color: #e9ecef;
            border: 3px solid #000;
            box-shadow: 4px 4px 0 #000;
        }
        .people-btn:hover {
            background-color: #ced4da;
        }
        #people {
            width: 100px;
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            border: 3px solid #000;
            margin: 0 1rem;
            border-radius: 0;
        }
        #people::-webkit-outer-spin-button, #people::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; }
        #people { -moz-appearance: textfield; }

        .submit-button {
            display: block;
            width: 100%;
            padding: 1.2rem;
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
                                    <h2>Step 3: 選擇人數</h2>
                                </div>

                                <!-- New Ticket Summary -->
                                <div class="ticket-summary">
                                    <div class="ticket-header">
                                        <h3>您已選擇</h3>
                                    </div>
                                    <div class="ticket-body">
                                        <div class="ticket-section">
                                            <i class="fas fa-film"></i>
                                            <h4>電影</h4>
                                            <p>${showtime.movie.title}</p>
                                        </div>
                                        <div class="ticket-section">
                                            <i class="fas fa-clock"></i>
                                            <h4>場次</h4>
                                            <%-- <p>${showtime.formattedTime}</p> --%>
                                            ${fn:replace(showtime.startTime, "T", " ")}
                                        </div>
                                    </div>
                                </div>

                                <form action="/seats" method="get" id="people-form">
                                    <input type="hidden" name="showtimeId" value="${showtime.id}" />
                                    
                                    <div class="form-group text-center">
                                        <label for="people" style="font-size: 1.2rem; font-weight: bold;">請選擇人數</label>
                                        <span>（剩餘可選人數：${availableSeats}）</span>
                                        <div class="people-selector">
                                            <div id="minus-btn" class="people-btn">-</div>
                                            <input type="number" id="people" name="people" min="1" max="${availableSeats}" value="1" required />
                                            
                                            <div id="plus-btn" class="people-btn">+</div>
                                        </div>
                                    </div>

                                    <button type="submit" class="submit-button">下一步：選擇座位</button>
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
            $('#minus-btn').click(function() {
                var count = parseInt($('#people').val()) - 1;
                count = count < 1 ? 1 : count;
                $('#people').val(count);
            });

            $('#plus-btn').click(function() {
                var count = parseInt($('#people').val()) + 1;
                count = count > 10 ? 10 : count; // Assuming max 10 tickets
                $('#people').val(count);
            });

            // Add submit handler to the form
            $('#people-form').submit(function(e) {
                var peopleValue = $('#people').val();
            });
        });
    </script>
</body>
</html>
