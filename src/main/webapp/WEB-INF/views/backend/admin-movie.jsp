<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>後台管理系統 | Movie</title>

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
            <a href="${pageContext.request.contextPath}/admin/movie" class="nav-link active">
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
            <h1>電影管理</h1>
          </div>
        </div>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header d-flex align-items-center">
            <h3 class="card-title mb-0">電影列表</h3>
            <div class="card-tools ml-auto">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addMovieModal"><i class="fas fa-plus"></i> 新增電影</button>
            </div>
          </div>
          <div class="card-body">
            <table id="movieTable" class="table table-bordered table-striped">
              <thead>
              <tr>
                <th>片名</th>
                <th>導演</th>
                <th>上映日期</th>
                <th>分級</th>
                <th>場次</th>
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

<!-- DETAILS MOVIE MODAL -->
<div class="modal fade" id="MovieDetailModal" tabindex="-1" role="dialog" aria-labelledby="MovieDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Content will be loaded here by AJAX -->
        </div>
    </div>
</div>

<!-- EDIT MOVIE MODAL -->
<div class="modal fade" id="editMovieModal" tabindex="-1" role="dialog" aria-labelledby="editMovieModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="editMovieForm">
          <input type="hidden" id="editMovieId" name="id">
          <div class="modal-header">
            <h3 class="modal-title" id="editMovieModalLabel">修改電影</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="editTitle" class="form-label">片名</label>
                <input type="text" class="form-control" id="editTitle" name="title" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="editDirector" class="form-label">導演</label>
                <input type="text" class="form-control" id="editDirector" name="director">
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="editPremiereDate" class="form-label">上映日期</label>
                <input type="date" class="form-control" id="editPremiereDate" name="premiereDate">
              </div>
              <div class="col-md-6 mb-3">
                <label for="editDuration" class="form-label">電影時長 (分鐘)</label>
                <input type="number" class="form-control" id="editDuration" name="duration" min="1">
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">字幕</label><br>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="中文"><label class="form-check-label">中文</label></div>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="英文"><label class="form-check-label">英文</label></div>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="日文"><label class="form-check-label">日文</label></div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="editRating" class="form-label">分級</label>
                <select class="form-control" id="editRating" name="rating"><option>普遍級</option><option>保護級</option><option>輔12級</option><option>輔15級</option><option>限制級</option></select>
              </div>
            </div>
            <div class="mb-3">
              <label for="editDescription" class="form-label">電影介紹</label>
              <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
            </div>
            <div class="mb-3">
              <label for="editPosterImage" class="form-label">更換海報 (可選)</label>
              <input type="file" class="form-control" id="editPosterImage" name="posterImage">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            <button type="submit" class="btn btn-primary">儲存變更</button>
          </div>
        </form>
      </div>
    </div>
</div>

<!-- ADD MOVIE MODAL -->
<div class="modal fade" id="addMovieModal" tabindex="-1" role="dialog" aria-labelledby="addMovieModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="addMovieForm">
          <div class="modal-header">
            <h3 class="modal-title" id="addMovieModalLabel">新增電影</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="title" class="form-label">片名</label>
                <input type="text" class="form-control" id="title" name="title" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="director" class="form-label">導演</label>
                <input type="text" class="form-control" id="director" name="director">
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="premiereDate" class="form-label">上映日期</label>
                <input type="date" class="form-control" id="premiereDate" name="premiereDate">
              </div>
              <div class="col-md-6 mb-3">
                <label for="duration" class="form-label">電影時長 (分鐘)</label>
                <input type="number" class="form-control" id="duration" name="duration" min="1">
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">字幕</label><br>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="中文"><label class="form-check-label">中文</label></div>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="英文"><label class="form-check-label">英文</label></div>
                <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="subtitles" value="日文"><label class="form-check-label">日文</label></div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="rating" class="form-label">分級</label>
                <select class="form-control" id="rating" name="rating"><option>普遍級</option><option>保護級</option><option>輔12級</option><option>輔15級</option><option>限制級</option></select>
              </div>
            </div>
            <div class="mb-3">
              <label for="description" class="form-label">電影介紹</label>
              <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>
            <div class="mb-3">
              <label for="posterImage" class="form-label">海報上傳</label>
              <input type="file" class="form-control" id="posterImage" name="posterImage">
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

  var movieTable = $("#movieTable").DataTable({
    "responsive": true, 
    "autoWidth": false,
    "processing": true,
    "ajax": {
      "url": contextPath + "/admin/api/movies",
      "dataSrc": ""
    },
    "columns": [
      { "data": "title" },
      { "data": "director" },
      { "data": "premiereDate" },
      { "data": "rating" },
      { 
        "data": null,
        "render": function (data, type, row) {
          return '<a href="' + contextPath + '/admin/showtime">管理場次</a>';
        },
        "orderable": false
      },
      { 
        "data": "id",
        "render": function (data, type, row) {
          return '<button type="button" class="btn btn-sm btn-info btn-detail" data-id="' + data + '">詳細</button> ' +
                 '<button type="button" class="btn btn-sm btn-warning btn-edit" data-id="' + data + '">修改</button> ' +
                 '<button type="button" class="btn btn-sm btn-danger btn-delete" data-id="' + data + '">刪除</button>';
        },
        "orderable": false
      }
    ],
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Chinese-traditional.json"
    }
  });

  // Handle Delete Button Click
  $('#movieTable tbody').on('click', '.btn-delete', function () {
    var movieId = $(this).data('id');
    
    if (confirm('您確定要刪除這部電影嗎？')) {
      $.ajax({
        url: contextPath + '/admin/api/movies/' + movieId,
        type: 'DELETE',
        success: function(result) {
          alert('電影刪除成功！');
          movieTable.ajax.reload(); // Reload the table data
        },
        error: function(xhr, status, error) {
          alert('刪除失敗，請稍後再試。');
          console.error("Error deleting movie: ", error);
        }
      });
    }
  });

  // Handle Add Movie Form Submission
  $('#addMovieForm').on('submit', function(event) {
    event.preventDefault();
    
    var formData = new FormData(this);

    $.ajax({
      url: contextPath + '/admin/api/movies',
      type: 'POST',
      data: formData,
      processData: false, // Important for FormData
      contentType: false, // Important for FormData
      success: function(result) {
        alert('電影新增成功！');
        $('#addMovieModal').modal('hide');
        $('#addMovieForm')[0].reset(); // Reset form
        movieTable.ajax.reload(); // Reload DataTable
      },
      error: function(xhr, status, error) {
        alert('新增失敗，請檢查欄位或稍後再試。');
        console.error("Error adding movie: ", error);
      }
    });
  });

  // Handle Details Button Click
  $('#movieTable tbody').on('click', '.btn-detail', function () {
    var movieId = $(this).data('id');

    $.ajax({
      url: contextPath + '/admin/api/movies/' + movieId,
      type: 'GET',
      success: function(movie) {
        // Format subtitles with '/'
        var subtitlesText = movie.subtitles && movie.subtitles.length > 0 
                            ? movie.subtitles.join(' / ') 
                            : '無';

        var posterHtml = movie.posterUrl
                         ? '<img src="' + contextPath + movie.posterUrl + '" class="img-fluid" alt="Movie Poster">'
                         : '<p>無海報</p>';

        // Use grid system for layout
        var modalContent = '<div class="modal-header">' +
                           '  <h4 class="modal-title">' + movie.title + '</h4>' +
                           '  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                           '</div>' +
                           '<div class="modal-body">' +
                           '  <div class="row">' +
                           '    <div class="col-md-4">' + posterHtml + '</div>' +
                           '    <div class="col-md-8">' +
                           '      <p><strong>導演:</strong> ' + movie.director + '</p>' +
                           '      <p><strong>上映日期:</strong> ' + movie.premiereDate + '</p>' +
                           '      <p><strong>分級:</strong> ' + movie.rating + '</p>' +
                           '      <p><strong>時長:</strong> ' + movie.duration + ' 分鐘</p>' +
                           '      <p><strong>字幕:</strong> ' + subtitlesText + '</p>' +
                           '      <hr>' +
                           '      <p><strong>簡介:</strong><br>' + movie.description + '</p>' +
                           '    </div>' +
                           '  </div>' +
                           '</div>' +
                           '<div class="modal-footer">' +
                           '  <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>' +
                           '</div>';
        
        $('#MovieDetailModal .modal-content').html(modalContent);
        $('#MovieDetailModal').modal('show');
      },
      error: function(xhr, status, error) {
        alert('無法取得電影詳細資料。');
        console.error("Error fetching movie details: ", error);
      }
    });
  });

  // Handle Edit Button Click (to populate form)
  $('#movieTable tbody').on('click', '.btn-edit', function () {
    var movieId = $(this).data('id');

    $.ajax({
      url: contextPath + '/admin/api/movies/' + movieId,
      type: 'GET',
      success: function(movie) {
        // Populate the form fields
        $('#editMovieId').val(movie.id);
        $('#editTitle').val(movie.title);
        $('#editDirector').val(movie.director);
        $('#editPremiereDate').val(movie.premiereDate);
        $('#editDuration').val(movie.duration);
        $('#editRating').val(movie.rating);
        $('#editDescription').val(movie.description);

        // Handle checkboxes for subtitles
        $('#editMovieForm input[name="subtitles"]').prop('checked', false); // Reset all checkboxes first
        if (movie.subtitles && movie.subtitles.length > 0) {
          movie.subtitles.forEach(function(subtitle) {
            $('#editMovieForm input[name="subtitles"][value="' + subtitle + '"]').prop('checked', true);
          });
        }
        
        // Show the modal
        $('#editMovieModal').modal('show');
      },
      error: function(xhr, status, error) {
        alert('無法取得電影資料以進行編輯。');
        console.error("Error fetching movie for edit: ", error);
      }
    });
  });

  // Handle Edit Form Submission
  $('#editMovieForm').on('submit', function(event) {
    event.preventDefault();
    
    var movieId = $('#editMovieId').val(); // Get movie ID from hidden field
    var formData = new FormData(this);

    $.ajax({
      url: contextPath + '/admin/api/movies/' + movieId,
      type: 'PUT',
      data: formData,
      processData: false, // Important for FormData
      contentType: false, // Important for FormData
      success: function(result) {
        alert('電影更新成功！');
        $('#editMovieModal').modal('hide');
        $('#editMovieForm')[0].reset(); // Reset form
        movieTable.ajax.reload(); // Reload DataTable
      },
      error: function(xhr, status, error) {
        alert('更新失敗，請檢查欄位或稍後再試。');
        console.error("Error updating movie: ", error);
      }
    });
  });

});
</script>
</body>
</html>