<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>後台管理系統 | User</title>

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
            <a href="${pageContext.request.contextPath}/admin/user" class="nav-link active">
              <i class="nav-icon fas fa-users"></i>
              <p>會員管理</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/order" class="nav-link">
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
            <h1>會員管理</h1>
          </div>
        </div>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header d-flex align-items-center">
            <h3 class="card-title mb-0">會員列表</h3>
            <div class="card-tools ml-auto">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal"><i class="fas fa-plus"></i> 新增會員</button>
            </div>
          </div>
          <div class="card-body">
            <table id="userTable" class="table table-bordered table-striped">
              <thead>
              <tr>
                <th>ID</th>
                <th>使用者名稱</th>
                <th>帳號</th>
                <th style="width: 120px;">操作</th>
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

<!-- ADD USER MODAL -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="addUserForm">
          <div class="modal-header">
            <h3 class="modal-title" id="addUserModalLabel">新增會員</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="addName" class="form-label">名稱</label>
              <input type="text" class="form-control" id="addName" name="name" required>
            </div>
            <div class="mb-3">
              <label for="addAccount" class="form-label">帳號 (Email)</label>
              <input type="email" class="form-control" id="addAccount" name="account" required>
            </div>
            <div class="mb-3">
              <label for="addPassword" class="form-label">密碼</label>
              <input type="password" class="form-control" id="addPassword" name="password" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">新增</button>
          </div>
        </form>
      </div>
    </div>
</div>

<!-- EDIT USER MODAL -->
<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="editUserForm">
          <input type="hidden" id="editUserId" name="id">
          <div class="modal-header">
            <h3 class="modal-title" id="editUserModalLabel">修改會員</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="editName" class="form-label">名稱</label>
              <input type="text" class="form-control" id="editName" name="name" required>
            </div>
            <div class="mb-3">
              <label for="editAccount" class="form-label">帳號</label>
              <input type="text" class="form-control" id="editAccount" name="account" required>
            </div>
            <div class="mb-3">
              <label for="editPassword" class="form-label">密碼</label>
              <input type="password" class="form-control" id="editPassword" name="password" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">修改</button>
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

  var userTable = $("#userTable").DataTable({
    "responsive": true, 
    "autoWidth": false,
    "processing": true,
    "ajax": {
      "url": contextPath + "/admin/api/users",
      "dataSrc": ""
    },
    "columns": [
      { "data": "id" },
      { "data": "name" },
      { "data": "account" },
      { 
        "data": "id",
        "render": function (data, type, row) {
          // 我們暫時不提供編輯功能，因為安全的密碼管理比較複雜
          return '<button type="button" class="btn btn-sm btn-warning btn-edit" data-id="' + data + '">修改</button> ' + 
                  '<button type="button" class="btn btn-sm btn-danger btn-delete" data-id="' + data + '">刪除</button>';
        },
        "orderable": false
      }
    ],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Chinese-traditional.json"
    }
  });

  // Handle Add User Form Submission
  $('#addUserForm').on('submit', function(event) {
    event.preventDefault();
    
    var userData = {
        name: $('#addName').val(),
        account: $('#addAccount').val(),
        password: $('#addPassword').val()
    };

    $.ajax({
      url: contextPath + '/admin/api/users',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(userData),
      success: function(result) {
        alert('會員新增成功！');
        $('#addUserModal').modal('hide');
        $('#addUserForm')[0].reset();
        userTable.ajax.reload();
      },
      error: function(xhr, status, error) {
        alert('新增失敗，請檢查欄位或稍後再試。');
      }
    });
  });

  // Handle Delete Button Click
  $('#userTable tbody').on('click', '.btn-delete', function () {
    var userId = $(this).data('id');
    
    if (confirm('您確定要刪除這位會員嗎？這將會是一個硬刪除，無法復原。')) {
      $.ajax({
        url: contextPath + '/admin/api/users/' + userId,
        type: 'DELETE',
        success: function(result) {
          alert('會員刪除成功！');
          userTable.ajax.reload();
        },
        error: function(xhr, status, error) {
          if (xhr.status == 404) {
            alert('找不到該會員，可能已被刪除。');
          } else {
            alert('刪除失敗，請稍後再試。');
          }
        }
      });
    }
  });

  $('#userTable tbody').on('click', '.btn-edit', function () {
      var userId = $(this).data('id');

      $.ajax({
        url: contextPath + '/admin/api/users/' + userId,
        type: 'GET',
        success: function(user) {
          $('#editUserId').val(user.id);
          $('#editName').val(user.name);
          $('#editAccount').val(user.account);
          $('#editPassword').val(""); // 預設清空，不回填
          $('#editUserModal').modal('show');
        },
        error: function(xhr, status, error) {
          alert('無法取得會員資料以進行編輯。');
          console.error("Error fetching user for edit: ", error);
        }
      });
  });

  $('#editUserForm').on('submit', function(event) {
    event.preventDefault();

    var userId = $('#editUserId').val();
    var userData = {
      name: $('#editName').val(),
      account: $('#editAccount').val(),
      password: $('#editPassword').val() || null // 如果空的，就代表不改密碼
    };

    $.ajax({
      url: contextPath + '/admin/api/users/' + userId,
      type: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify(userData),
      success: function(result) {
        alert('會員更新成功！');
        $('#editUserModal').modal('hide');
        $('#editUserForm')[0].reset(); // Reset form
        userTable.ajax.reload(); // Reload DataTable
      },
      error: function(xhr, status, error) {
        if (xhr.status === 404) {
          alert('找不到該會員，可能已被刪除。');
        } else {
          alert('更新失敗，請檢查欄位或稍後再試。');
        }
        console.error("Error updating user: ", error);
        }
    });
  })

});
</script>
</body>
</html>
