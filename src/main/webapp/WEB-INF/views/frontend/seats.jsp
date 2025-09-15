<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String people = request.getParameter("people");%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>選擇座位 - 文暨電影院</title>
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
        
        /* Ticket Summary Styles */
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

        /* Screen and Seating Styles */
        .screen {
            background-color: #343a40;
            color: white;
            padding: 1rem;
            margin: 2rem auto;
            width: 80%;
            border: 3px solid #000;
            box-shadow: 4px 4px 0 #000;
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .row {
            display: flex;
            justify-content: center;
            margin: 10px 0;
        }

        .seat {
            width: 35px;
            height: 35px;
            background-color: white;
            margin: 5px;
            border: 3px solid #000;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .seat.green {
            background-color: #28a745;
            color: white;
        }

        .seat.red {
            background-color: #dc3545;
            color: white;
            cursor: not-allowed;
            pointer-events: none;
        }

        .aisle {
            width: 35px;
        }

        .info-section {
            text-align: center;
            margin: 2rem 0;
            padding: 1rem;
            border: 3px solid #000;
            background-color: #f8f9fa;
        }

        .info-section p {
            font-size: 1.2rem;
            font-weight: bold;
            margin: 0;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .submit-button, .clear-button {
            flex: 1;
            padding: 1.2rem;
            font-size: 1.5rem;
            font-weight: bold;
            border: 3px solid #000;
            box-shadow: 4px 4px 0 #000;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .submit-button {
            background-color: #ffc107;
            color: black;
        }

        .submit-button:hover {
            background-color: #e0a800;
            box-shadow: 2px 2px 0 #000;
            transform: translate(2px, 2px);
        }

        .clear-button {
            background-color: #6c757d;
            color: white;
        }

        .clear-button:hover {
            background-color: #5a6268;
            box-shadow: 2px 2px 0 #000;
            transform: translate(2px, 2px);
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
                        <div class="col-md-10">
                            <div class="booking-container">
                                <div class="booking-header">
                                    <h2>Step 4: 選擇座位</h2>
                                </div>

                                <!-- Ticket Summary -->
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
                                            <p>${fn:replace(showtime.startTime, "T", " ")}</p>
                                        </div>
                                        <div class="ticket-section">
                                            <i class="fas fa-users"></i>
                                            <h4>人數</h4>
                                            <p><%= people != null ? people : "1" %> 人</p>
                                        </div>
                                    </div>
                                </div>

                                <input type="hidden" id="showtimeId" value="${showtime.id}">

                                <div class="screen">螢幕</div>
                                <div id="seat-container"></div>
                                
                                <div class="info-section">
                                    <p id="info"></p>
                                </div>

                                <div class="button-group">
                                    <button type="button" id="clear-btn" class="clear-button">清除選擇</button>
                                    <button type="button" id="submit-btn" class="submit-button">確認座位</button>
                                </div>
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
        let maxSeats = parseInt("<%= people != null ? people : 1 %>") || 1;

        //座位預設內容
        const rows = 4; //有ABCD 排
        const seatsPerSide = 3; // 左右各 3 個

        const soldSeats = [        
            <c:forEach var="seat" items="${soldSeats}" varStatus="status">
            '${seat}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ]; // 資料庫已購買座位 (之後可替換)

        console.log("已售座位:", soldSeats);

        const container = document.getElementById('seat-container');
        const info = document.getElementById('info');
        let selectedCount = 0;
        let selectedSeats = []; // 儲存選擇的座位

        info.textContent = `最多可選`+ maxSeats +`個座位，目前已選0個`;

        for (let r = 0; r < rows; r++) {
            const rowDiv = document.createElement('div');
            rowDiv.className = 'row';

            for (let s = 0; s < seatsPerSide * 2 + 1; s++) {
                if (s === seatsPerSide) {
                    const aisle = document.createElement('div');
                    aisle.className = 'aisle';
                    rowDiv.appendChild(aisle);
                } else {
                    const seat = document.createElement('div');
                    seat.className = 'seat';
                        // row 字母
                        const rowLetter = String.fromCharCode(65 + r); // 65 是 'A'
                        // 座位數字
                        let seatNumber;
                        if (s < seatsPerSide) {
                            seatNumber = s + 1;
                        } else {
                            seatNumber = s;
                        }
                        const seatId = rowLetter + "-" + seatNumber;
                        seat.textContent = seatId; // 顯示座位編號
                    if (soldSeats.includes(seatId)) {
                        seat.classList.add('red');
                    }

                    seat.addEventListener('click', () => {

                        if (seat.classList.contains('red')) return;

                        if (seat.classList.contains('green')) {
                            seat.classList.remove('green');
                            selectedCount--;
                            // 從選擇列表中移除
                            const index = selectedSeats.indexOf(seatId);
                            if (index > -1) {
                                selectedSeats.splice(index, 1);
                            }
                        } else {
                            if (selectedCount < maxSeats) {
                                seat.classList.add('green');
                                selectedCount++;
                                // 添加到選擇列表
                                selectedSeats.push(seatId);
                            } else {
                                alert(`最多只能選` + maxSeats + `個座位`);
                            }
                        }
                        info.textContent = `最多可選` + maxSeats + `個座位，目前已選` + selectedCount + `個`;
                        
                        // 儲存選擇的座位到localStorage
                        localStorage.setItem('selectedSeats', JSON.stringify(selectedSeats));

                    });

                    rowDiv.appendChild(seat);
                }
            }
            container.appendChild(rowDiv);
        }

        // 按鈕事件處理
        document.getElementById('submit-btn').addEventListener('click', function(event) {
            event.preventDefault(); // 防止預設的提交行為
            
            if (selectedSeats.length === 0) {
                alert('請先選擇座位！');
                return;
            }
            
            if (selectedSeats.length !== parseInt(maxSeats)) {
                if (!confirm(`您選擇了 ${selectedSeats.length} 個座位，但可以選擇 ${maxSeats} 個座位。是否確認送出？`)) {
                    return;
                }
            }
            
            // 跳轉到訂單頁面並傳送座位資訊
        const showtimeId = document.getElementById("showtimeId").value;

        const seatsParam = encodeURIComponent(JSON.stringify(selectedSeats));

        console.log("送出時 selectedSeats:", selectedSeats);
        console.log("送出時 maxSeats:", maxSeats);
        console.log("送出時 showtimeId:", showtimeId);
        console.log("送出時 seatsParam:", seatsParam);

        window.location.href = "/checkorder?showtimeId=" + showtimeId + "&people=" + maxSeats + "&seats=" + seatsParam;
        //window.location.href = `/order?showtimeId=${showtime.id}&people=${maxSeats}&seats=${seatsParam}`;
        
        });

        document.getElementById('clear-btn').addEventListener('click', function(event) {
            event.preventDefault(); // 防止預設的提交行為
            
            if (confirm('確定要清除所有選擇的座位嗎？')) {
                // 清除所有選擇
                document.querySelectorAll('.seat.green').forEach(seat => {
                    seat.classList.remove('green');
                });
                selectedCount = 0;
                selectedSeats = [];
                //清除後的顯示
                info.textContent = `最多可選`+ maxSeats +`個座位，目前已選0個`; 
                
                // 清除localStorage
                localStorage.removeItem('selectedSeats');
            }
        });
    </script>
</body>
</html>
