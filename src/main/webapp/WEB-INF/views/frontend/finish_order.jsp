<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單詳情 - 文暨電影院</title>
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
        .ticket-summary { border: 3px solid #000; margin-bottom: 2rem; background-color: #f8f9fa; }
        .ticket-header { background-color: #000; color: #fff; padding: 0.5rem; text-align: center; }
        .ticket-header h3 { margin: 0; font-size: 1.2rem; font-weight: bold; }
        .ticket-body { display: flex; justify-content: space-around; padding: 1.5rem 1rem; text-align: center; }
        .ticket-section { flex: 1; }
        .ticket-section i { font-size: 2rem; margin-bottom: 0.75rem; color: #343a40; }
        .ticket-section h4 { font-size: 1rem; font-weight: normal; color: #6c757d; margin-bottom: 0.25rem; text-transform: uppercase; }
        .ticket-section p { font-size: 1.3rem; font-weight: bold; margin: 0; word-wrap: break-word; }

        .order-details {
            border: 3px solid #000;
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: #f8f9fa;
        }
        .order-details h3 {
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 2px solid #000;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }
        .order-details p {
            font-size: 1.1rem;
            margin-bottom: 0.75rem;
        }
        .order-details strong {
            font-weight: bold;
            color: #343a40;
        }
        .order-details .total-amount {
            font-size: 1.8rem;
            font-weight: bold;
            color: #dc3545;
            margin-top: 1.5rem;
            text-align: right;
        }
        .selected-seats-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        .selected-seat-item {
            background-color: #ffc107;
            border: 2px solid #000;
            padding: 0.3rem 0.7rem;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 2rem;
        }
        .action-btn {
            flex: 1;
            padding: 1rem;
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
        #btnLinePay { 
            background-color: #28a745; 
            color: white; 
        }
        #btnLinePay:hover { 
            background-color: #218838;  
            color: white; 
        }
        .home-button { 
            background-color: #007bff; 
            color: white; 
        }
        .home-button:hover { 
            background-color: #0056b3;
            color: white; 
        }

        .success-indicator {
            text-align: center;
            padding: 1rem;
            background-color: #d4edda;
            border: 3px solid #155724;
            margin-bottom: 2rem;
            color: #155724;
        }
        .success-indicator i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #28a745;
        }
        .success-indicator h4 {
            font-size: 1.5rem;
            font-weight: bold;
            margin: 0;
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
                                    <h2>訂單詳情</h2>
                                </div>

                                <div class="success-indicator">
                                    <i class="fas fa-check-circle"></i>
                                    <h4>訂單建立成功！</h4>
                                </div>

                                <div class="ticket-summary">
                                    <div class="ticket-header">
                                        <h3>您的購票資訊</h3>
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
                                            <p>${people}</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="order-details">
                                    <h3>訂單明細</h3>
                                    <p><strong>訂單編號：</strong> ${orderId}</p>
                                    <p><strong>客戶名稱：</strong> ${customerName}</p>
                                    <p><strong>已選座位：</strong>
                                        <div class="selected-seats-list">
                                            <c:forEach var="seat" items="${selectedSeats}">
                                                <span class="selected-seat-item">${seat}</span>
                                            </c:forEach>
                                        </div>
                                    </p>
                                    <p><strong>訂單狀態：</strong> ${orderStatus}</p>
                                    <p><strong>訂單日期：</strong> ${fn:replace(fn:substringBefore(orderDate, "."), "T", " ")}</p>
                                    <div class="total-amount">總金額：NT$ ${totalAmount}</div>
                                </div>

                                <div class="action-buttons">
                                    <form action="member_menu" style="display: contents;">
                                        <button class="action-btn home-button">回會員頁面</button>
                                    </form>
                                    <button type="button" id="btnLinePay" class="action-btn">LINE Pay 付款</button>
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

    <!-- 提供給 JS 的原始資料（不做格式化） -->
    <div id="orderData"
         data-order-number="${orderId}"
         style="display: none;">
    </div>

    <!-- SCRIPTS -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script>
      const ctx = '${pageContext.request.contextPath}';
      const orderEl = document.getElementById('orderData');
      const btnLinePay = document.getElementById('btnLinePay');

      btnLinePay.addEventListener('click', async () => {
        try {
          btnLinePay.disabled = true;
          btnLinePay.textContent = '處理中…';

          const orderNumber = orderEl.dataset.orderNumber;

          const params = new URLSearchParams();
          params.set('orderNumber', orderNumber);

          const res = await fetch(`${ctx}/orders/checkout`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
          });

          if (!res.ok) {
            alert('建立訂單失敗');
            return;
          }

          const data = await res.json(); // 期待 {orderNumber, paymentUrl}
          if (data && data.paymentUrl) {
            window.location = data.paymentUrl; // 導到 LINE Pay
          } else {
            alert('未取得 paymentUrl');
          }
        } catch (err) {
          console.error(err);
          alert('系統忙碌，請稍後再試');
        } finally {
          btnLinePay.disabled = false;
          btnLinePay.textContent = 'LINE Pay 付款';
        }
      });
    </script>
</body>
</html>