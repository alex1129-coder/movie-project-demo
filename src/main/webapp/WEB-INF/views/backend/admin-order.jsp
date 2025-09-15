<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>後台管理系統 | Order</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="#" class="brand-link">
      <img src="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Movie Admin</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="${pageContext.request.contextPath}/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Admin</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>儀表板</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/movie" class="nav-link">
              <i class="nav-icon fas fa-film"></i>
              <p>電影管理</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/showtime" class="nav-link">
              <i class="nav-icon fas fa-clock"></i>
              <p>場次管理</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/user" class="nav-link">
              <i class="nav-icon fas fa-users"></i>
              <p>會員管理</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/order" class="nav-link active">
              <i class="nav-icon fas fa-receipt"></i>
              <p>訂單管理</p>
            </a>
          </li>
          <li class="nav-item">
            <form action="${pageContext.request.contextPath}/admin/logout" method="post" style="display: inline;">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <button type="submit" class="nav-link" style="background: none; border: none; width: 100%; text-align: left; padding: .5rem 1rem;">
                <i class="nav-icon fas fa-sign-out-alt"></i>
                <p>登出</p>
              </button>
            </form>
          </li>
        </ul>
      </nav>
    </div>
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>訂單管理</h1>
          </div>
        </div>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">訂單列表</h3>
          </div>
          <div class="card-body">
            <table id="orderTable" class="table table-bordered table-striped">
              <thead>
              <tr>
                <th>訂單編號</th>
                <th>使用者帳號</th>
                <th>總金額</th>
                <th>狀態</th>
                <th>建立時間</th>
                <th style="width: 180px;">操作</th>
              </tr>
              </thead>
              <tbody>
                <!-- Data will be loaded by DataTables -->
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>
  </div>

  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 1.0
    </div>
    <strong>Copyright &copy; 2025 <a href="#">aaj.io</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- DETAILS MODAL -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Content will be loaded here by AJAX -->
        </div>
    </div>
</div>

<!-- UPDATE STATUS MODAL -->
<div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="updateStatusForm">
          <input type="hidden" id="updateOrderId">
          <div class="modal-header">
            <h3 class="modal-title" id="updateStatusModalLabel">更新訂單狀態</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="orderStatusSelect" class="form-label">訂單狀態</label>
              <select class="form-control" id="orderStatusSelect" name="status" required>
                <option value="PENDING">待付款 (PENDING)</option>
                <option value="PAID">已付款 (PAID)</option>
                <option value="FAILED">失敗 (FAILED)</option>
                <option value="CANCELLED">已取消 (CANCELLED)</option>
                <option value="REFUNDED">已退款 (REFUNDED)</option>
              </select>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">儲存更新</button>
          </div>
        </form>
      </div>
    </div>
</div>


<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables  & Plugins -->
<script src="${pageContext.request.contextPath}/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/dist/js/adminlte.min.js"></script>

<!-- Custom App Script -->
<script>
$(function () {
  const contextPath = "${pageContext.request.contextPath}";

  var orderTable = $("#orderTable").DataTable({
    "responsive": true, 
    "autoWidth": false,
    "processing": true,
    "order": [[ 4, "desc" ]], // Default sort by created time descending
    "ajax": {
      "url": contextPath + "/admin/api/orders",
      "dataSrc": ""
    },
    "columns": [
      { "data": "orderNumber" },
      { "data": "userAccount" },
      { "data": "totalAmount" },
      { "data": "status" },
      { 
        "data": "createdAt",
        "render": function(data, type, row) {
          return data ? new Date(data).toLocaleString('sv-SE') : '';
        }
      },
      { 
        "data": "orderId",
        "render": function (data, type, row) {
          return '<button type="button" class="btn btn-sm btn-info btn-detail" data-id="' + data + '">詳細</button> ' +
                 '<button type="button" class="btn btn-sm btn-warning btn-update-status" data-id="' + data + '" data-status="' + row.status + '">更新狀態</button>';
        },
        "orderable": false
      }
    ],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Chinese-traditional.json"
    }
  });

  // Handle Details Button Click
  $('#orderTable tbody').on('click', '.btn-detail', function () {
    var orderId = $(this).data('id');

    $.ajax({
      url: contextPath + '/admin/api/orders/' + orderId,
      type: 'GET',
      success: function(order) {
        let ticketsHtml = '<p>此訂單無票券資訊。</p>';
        if (order.tickets && order.tickets.length > 0) {
            ticketsHtml = '<ul class="list-group">';
            order.tickets.forEach(function(ticket) {
                ticketsHtml += '<li class="list-group-item">' +
                               '<strong>' + ticket.movieTitle + '</strong><br>' +
                               '時間: ' + new Date(ticket.showtimeStartTime).toLocaleString('sv-SE') + '<br>' +
                               '座位: ' + ticket.seatRow + '排 ' + ticket.seatNumber + '號' +
                               '</li>';
            });
            ticketsHtml += '</ul>';
        }

        var modalContent = 
            '<div class="modal-header">' +
            '  <h4 class="modal-title">訂單詳細資料</h4>' +
            '  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
            '</div>' +
            '<div class="modal-body">' +
            '  <p><strong>訂單編號:</strong> ' + order.orderNumber + '</p>' +
            '  <p><strong>使用者:</strong> ' + order.userAccount + '</p>' +
            '  <p><strong>總金額:</strong> ' + order.totalAmount + '</p>' +
            '  <p><strong>訂單狀態:</strong> ' + order.status + '</p>' +
            '  <p><strong>建立時間:</strong> ' + new Date(order.createdAt).toLocaleString('sv-SE') + '</p>' +
            '  <p><strong>LinePay 交易ID:</strong> ' + (order.linepayTransactionId || 'N/A') + '</p>' +
            '  <hr>' +
            '  <h5>票券資訊</h5>' +
            ticketsHtml +
            '</div>' +
            '<div class="modal-footer">' +
            '  <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>' +
            '</div>';
        
        $('#orderDetailModal .modal-content').html(modalContent);
        $('#orderDetailModal').modal('show');
      },
      error: function(xhr, status, error) {
        alert('無法取得訂單詳細資料。');
      }
    });
  });

  // Handle Update Status Button Click (to populate form)
  $('#orderTable tbody').on('click', '.btn-update-status', function () {
    var orderId = $(this).data('id');
    var currentStatus = $(this).data('status');
    
    $('#updateOrderId').val(orderId);
    $('#orderStatusSelect').val(currentStatus);
    
    $('#updateStatusModal').modal('show');
  });

  // Handle Update Status Form Submission
  $('#updateStatusForm').on('submit', function(event) {
    event.preventDefault();
    
    var orderId = $('#updateOrderId').val();
    var newStatus = $('#orderStatusSelect').val();

    $.ajax({
      url: contextPath + '/admin/api/orders/' + orderId + '/status',
      type: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({ status: newStatus }),
      success: function(result) {
        alert('訂單狀態更新成功！');
        $('#updateStatusModal').modal('hide');
        orderTable.ajax.reload();
      },
      error: function(xhr, status, error) {
        alert('更新失敗，請稍後再試。');
      }
    });
  });

});
</script>
</body>
</html>
