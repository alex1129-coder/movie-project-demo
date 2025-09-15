<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  // 例: "" 或 "/movie"
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員註冊 - 文暨電影院</title>
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
            min-height: 750px;
        }
        .main-footer {
            flex-shrink: 0; /* Prevent footer from shrinking */
        }
        .register-box {
            width: 100%;
            max-width: 500px; /* Control the max width */
            border: 3px solid #000;
            box-shadow: 8px 8px 0 #000;
            border-radius: 0;
        }
        .register-card-header {
            text-align: center;
            padding: 2rem;
            border-bottom: 3px solid #000;
        }
        .register-card-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: bold;
        }
        .register-card-body {
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
        .btn-secondary {
            background-color: #a67c00;
            border-color: #000;
            color: white;
            font-weight: bold;
            border-width: 3px;
            border-radius: 0;
            box-shadow: 4px 4px 0 #000;
        }
        .btn-secondary:hover {
            background-color: #8c6500;
            border-color: #000;
            color: white;
        }
        .form-control {
            border-width: 3px;
            border-radius: 0;
            border-color: #000;
        }
        .msg {
            font-size: 0.85em;
            margin-top: 5px;
            font-weight: bold;
        }
        .msg.error {
            color: red;
        }
        .msg.success {
            color: green;
        }
        .account-row {
            display: flex;
            gap: 10px;
            align-items: end;
        }
        .account-row .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        .account-row button {
            height: calc(1.5em + 0.75rem + 8px); /* Match input height */
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
                            <a href="/checkMember" class="nav-link">購票</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- /.navbar -->
        
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <div class="card register-box">
                <div class="card-header register-card-header">
                    <h1>會員註冊</h1>
                </div>
                <div class="card-body register-card-body">
                    <form id="registerForm">
                        <div class="form-group">
                            <label for="account">帳號</label>
                            <div class="account-row">
                                <div class="form-group">
                                    <input type="text" id="account" name="account" class="form-control" placeholder="請輸入帳號" required>
                                </div>
                                <button type="button" id="checkAccountBtn" class="btn btn-secondary">檢查帳號</button>
                            </div>
                            <div id="accountMsg" class="msg"></div>
                        </div>

                        <div class="form-group">
                            <label for="password">密碼</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="請輸入密碼" required>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">確認密碼</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="再次輸入密碼" required>
                            <div id="passwordMsg" class="msg"></div>
                        </div>

                        <div class="form-group">
                            <label for="name">姓名</label>
                            <input type="text" id="name" name="name" class="form-control" placeholder="請輸入姓名" required>
                        </div>

                        <div class="form-group text-right">
                            <div>已經有帳號? <a href="<c:url value='/login'/>">點我登入</a></div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">註冊</button>
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

    <script>
      // 基底路徑（避免 context-path 造成 404）
      var base = "<%=ctx%>";

      // 檢查帳號
      document.getElementById('checkAccountBtn').addEventListener('click', function() {
        var account = document.getElementById('account').value.trim();
        var msg = document.getElementById('accountMsg');

        if (!account) {
          msg.textContent = '請先輸入帳號';
          msg.className = 'msg error';
          return;
        }

        fetch(base + '/users/exists?account=' + encodeURIComponent(account))
          .then(function(res) { return res.json(); })
          .then(function(data) {
            if (data.exists) {
              msg.textContent = '此帳號已註冊';
              msg.className = 'msg error';
            } else {
              msg.textContent = '此帳號可以使用';
              msg.className = 'msg success';
            }
          })
          .catch(function() {
            msg.textContent = '檢查失敗，請稍後再試';
            msg.className = 'msg error';
          });
      });

      // 密碼一致性檢查
      document.getElementById('confirmPassword').addEventListener('input', function() {
        var pwd = document.getElementById('password').value;
        var confirmPwd = document.getElementById('confirmPassword').value;
        var msg = document.getElementById('passwordMsg');

        if (pwd && confirmPwd) {
          if (pwd !== confirmPwd) {
            msg.textContent = '密碼與確認密碼不一致';
            msg.className = 'msg error';
          } else {
            msg.textContent = '密碼一致';
            msg.className = 'msg success';
          }
        } else {
          msg.textContent = '';
        }
      });

      // 送出註冊（POST JSON）
      document.getElementById('registerForm').addEventListener('submit', function(e) {
        e.preventDefault();

        var account = document.getElementById('account').value.trim();
        var password = document.getElementById('password').value;
        var confirmPassword = document.getElementById('confirmPassword').value;
        var name = document.getElementById('name').value.trim();

        if (!account || !password || !confirmPassword || !name) {
          alert('請完整填寫表單');
          return;
        }
        if (password !== confirmPassword) {
          alert('密碼不一致');
          return;
        }

        var payload = { account: account, password: password, name: name };

        fetch(base + '/users/register', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        })
        .then(function(res) {
          return res.json().then(function(data){ return { ok: res.ok, status: res.status, data: data }; });
        })
        .then(function(result) {
          if (result.ok && result.data && result.data.success) {
            alert('註冊成功！會員編號：' + result.data.id + '，請重新登入。');
            // 導回會員登入頁（不保留歷史紀錄，避免使用者按返回回到註冊頁）
            window.location.replace(base + '/login');
          } else {
            var msg = (result.data && result.data.message) ? result.data.message : ('註冊失敗 (HTTP ' + result.status + ')');
            alert(msg);
          }
        })
        .catch(function() {
          alert('系統忙碌，請稍後再試');
        });
      });
    </script>
</body>
</html>