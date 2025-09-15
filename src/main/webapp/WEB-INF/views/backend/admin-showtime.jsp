<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>後台管理系統 | Showtime</title>

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
            <a href="${pageContext.request.contextPath}/admin/showtime" class="nav-link active">
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
            <h1>場次管理</h1>
          </div>
        </div>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header d-flex align-items-center">
            <h3 class="card-title mb-0">場次列表</h3>
            <div class="card-tools ml-auto">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addShowtimeModal"><i class="fas fa-plus"></i> 新增場次</button>
            </div>
          </div>
          <div class="card-body">
            <table id="showtimeTable" class="table table-bordered table-striped">
              <thead>
              <tr>
                <th>電影片名</th>
                <th>放映時間</th>
                <th>票價</th>
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

<!-- ADD SHOWTIME MODAL -->
<div class="modal fade" id="addShowtimeModal" tabindex="-1" role="dialog" aria-labelledby="addShowtimeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="addShowtimeForm">
          <div class="modal-header">
            <h3 class="modal-title" id="addShowtimeModalLabel">新增場次</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="addMovieSelect" class="form-label">選擇電影</label>
              <select class="form-control" id="addMovieSelect" name="movieId" required>
                <option value="">-- 請選擇電影 --</option>
              </select>
            </div>
            <div class="mb-3">
              <label for="addShowtimeDatetime" class="form-label">放映時間</label>
              <input type="datetime-local" class="form-control" id="addShowtimeDatetime" name="showtimeDatetime" required>
            </div>
            <!-- Removed theaterName input -->
            <!-- Removed availableSeats input -->
            <!-- Removed ticketPrice input -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">新增</button>
          </div>
        </form>
      </div>
    </div>
</div>

<!-- EDIT SHOWTIME MODAL -->
<div class="modal fade" id="editShowtimeModal" tabindex="-1" role="dialog" aria-labelledby="editShowtimeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="editShowtimeForm">
          <input type="hidden" id="editShowtimeId" name="id">
          <div class="modal-header">
            <h3 class="modal-title" id="editShowtimeModalLabel">修改場次</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="editMovieSelect" class="form-label">選擇電影</label>
              <select class="form-control" id="editMovieSelect" name="movieId" required>
                <option value="">-- 請選擇電影 --</option>
              </select>
            </div>
            <div class="mb-3">
              <label for="editShowtimeDatetime" class="form-label">放映時間</label>
              <input type="datetime-local" class="form-control" id="editShowtimeDatetime" name="showtimeDatetime" required>
            </div>
            <!-- Removed theaterName input -->
            <!-- Removed availableSeats input -->
            <!-- Removed ticketPrice input -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">儲存變更</button>
          </div>
        </form>
      </div>
    </div>
</div>

<!-- DETAILS SHOWTIME MODAL -->
<div class="modal fade" id="showtimeDetailModal" tabindex="-1" role="dialog" aria-labelledby="showtimeDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Content will be loaded here by AJAX -->
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
  let allMovies = []; // To store all movies for dropdowns

  // Function to fetch all movies and populate dropdowns
  function populateMovieDropdowns() {
    $.ajax({
      url: contextPath + "/admin/api/movies",
      type: "GET",
      success: function(movies) {
        allMovies = movies; // Store for later use
        var movieSelects = $('#addMovieSelect, #editMovieSelect');
        movieSelects.empty();
        movieSelects.append('<option value="">-- 請選擇電影 --</option>');
        movies.forEach(function(movie) {
          movieSelects.append('<option value="' + movie.id + '">' + movie.title + '</option>');
        });
      },
      error: function(xhr, status, error) {
        console.error("Error fetching movies for dropdown: ", error);
        alert("無法載入電影列表，請檢查後端伺服器是否已啟動。");
      }
    });
  }

  // Initialize DataTables
  var showtimeTable = $("#showtimeTable").DataTable({
    "responsive": true, 
    "autoWidth": false,
    "processing": true,
    "ajax": {
      "url": contextPath + "/admin/api/showtimes",
      "dataSrc": ""
    },
    "columns": [
      { 
        "data": "movieTitle", // Use movieTitle from DTO
        "render": function(data, type, row) {
          return data || '未知電影'; // Handle case where movie might be null or title missing
        }
      },
      { 
        "data": "startTime",
        "render": function(data, type, row) {
          if (data) {
            // Assuming data is in "YYYY-MM-DDTHH:MM:SS" format
            return data.replace('T', ' ').substring(0, 16); 
          }
          return '';
        }
      },
      { 
        "data": null, // Placeholder for ticket price
        "render": function(data, type, row) {
          return '300'; // Hardcoded price
        }
      },
      { 
        "data": "id",
        "render": function (data, type, row) {
          return '<button type="button" class="btn btn-sm btn-info btn-detail" data-id="' + data + '">詳細</button> ' +
                 '<button type="button" class="btn btn-sm btn-warning btn-edit" data-id="' + data + '">修改</button> ' +
                 '<button type="button" class="btn btn-sm btn-danger btn-delete" data-id="' + data + '">刪除</button> ';
        },
        "orderable": false
      }
    ],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Chinese-traditional.json"
    }
  });

  // Populate movie dropdowns when add/edit modal is shown
  $('#addShowtimeModal').on('show.bs.modal', function () {
    populateMovieDropdowns();
  });
  $('#editShowtimeModal').on('show.bs.modal', function () {
    populateMovieDropdowns();
  });

  // Handle Delete Button Click
  $('#showtimeTable tbody').on('click', '.btn-delete', function () {
    var showtimeId = $(this).data('id');
    
    if (confirm('您確定要刪除這場次嗎？')) {
      $.ajax({
        url: contextPath + '/admin/api/showtimes/' + showtimeId,
        type: 'DELETE',
        success: function(result) {
          alert('場次刪除成功！');
          showtimeTable.ajax.reload();
        },
        error: function(xhr, status, error) {
          alert('刪除失敗，請稍後再試。');
          console.error("Error deleting showtime: ", error);
        }
      });
    }
  });

  // Handle Add Showtime Form Submission
  $('#addShowtimeForm').on('submit', function(event) {
    event.preventDefault();
    
    var formData = new FormData(this);
    // Convert form data to JSON object for API
    var showtimeData = {};
    formData.forEach(function(value, key){
        if (key === 'movieId') {
            showtimeData.movie = { id: value }; // Create nested movie object
        } else if (key === 'showtimeDatetime') {
            // Convert local datetime string to ISO format if needed by backend
            showtimeData[key] = value + ':00'; // Append seconds for ISO format
        } else {
            showtimeData[key] = value;
        }
    });
    showtimeData.price = 300; // Hardcode price

    $.ajax({
      url: contextPath + '/admin/api/showtimes',
      type: 'POST',
      contentType: 'application/json', // Sending JSON
      data: JSON.stringify(showtimeData),
      success: function(result) {
        alert('場次新增成功！');
        $('#addShowtimeModal').modal('hide');
        $('#addShowtimeForm')[0].reset();
        showtimeTable.ajax.reload();
      },
      error: function(xhr, status, error) {
        alert('新增失敗，請檢查欄位或稍後再試。');
        console.error("Error adding showtime: ", error);
      }
    });
  });

  // Handle Edit Button Click (to populate form)
  $('#showtimeTable tbody').on('click', '.btn-edit', function () {
    var showtimeId = $(this).data('id');

    $.ajax({
      url: contextPath + '/admin/api/showtimes/' + showtimeId,
      type: 'GET',
      success: function(showtime) {
        $('#editShowtimeId').val(showtime.id);
        $('#editMovieSelect').val(showtime.movieId); // Use movieId from DTO
        $('#editShowtimeDatetime').val(showtime.startTime.substring(0, 16)); // Format for datetime-local
        // Removed theaterName, availableSeats, ticketPrice population
        
        $('#editShowtimeModal').modal('show');
      },
      error: function(xhr, status, error) {
        alert('無法取得場次資料以進行編輯。');
        console.error("Error fetching showtime for edit: ", error);
      }
    });
  });

  // Handle Edit Form Submission
  $('#editShowtimeForm').on('submit', function(event) {
    event.preventDefault();
    
    var showtimeId = $('#editShowtimeId').val();
    var formData = new FormData(this);
    var showtimeData = {};
    formData.forEach(function(value, key){
        if (key === 'movieId') {
            showtimeData.movie = { id: value };
        } else if (key === 'showtimeDatetime') {
            showtimeData[key] = value + ':00';
        } else {
            showtimeData[key] = value;
        }
    });
    showtimeData.price = 300; // Hardcode price

    $.ajax({
      url: contextPath + '/admin/api/showtimes/' + showtimeId,
      type: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify(showtimeData),
      success: function(result) {
        alert('場次更新成功！');
        $('#editShowtimeModal').modal('hide');
        $('#editShowtimeForm')[0].reset();
        showtimeTable.ajax.reload();
      },
      error: function(xhr, status, error) {
        alert('更新失敗，請檢查欄位或稍後再試。');
        console.error("Error updating showtime: ", error);
      }
    });
  });

  // Handle Details Button Click
  $('#showtimeTable tbody').on('click', '.btn-detail', function () {
    var showtimeId = $(this).data('id');

    $.ajax({
      url: contextPath + '/admin/api/showtimes/' + showtimeId,
      type: 'GET',
      success: function(showtime) {
        var modalContent = '<div class="modal-header">' +
                            '  <h4 class="modal-title">' + (showtime.movieTitle || '未知電影') + ' - 場次詳細</h4>' +
                            '  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                            '</div>' +
                            '<div class="modal-body">' +
                            '  <p><strong>電影:</strong> ' + (showtime.movieTitle || '未知電影') + '</p>' +
                            '  <p><strong>放映時間:</strong> ' + showtime.startTime.replace('T', ' ').substring(0, 16) + '</p>' +
                            '  <p><strong>影廳:</strong> 主廳 </p>' +
                            '  <p><strong>票價:</strong> 300</p>' +
                            '</div>' +
                            '<div class="modal-footer">' +
                            '  <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>' +
                            '</div>';
        
        $('#showtimeDetailModal .modal-content').html(modalContent);
        $('#showtimeDetailModal').modal('show');
      },
      error: function(xhr, status, error) {
        alert('無法取得場次詳細資料。');
        console.error("Error fetching showtime details: ", error);
      }
    });
  });

  // Initial population of movie dropdowns
  populateMovieDropdowns();
});
</script>
</body>
</html>