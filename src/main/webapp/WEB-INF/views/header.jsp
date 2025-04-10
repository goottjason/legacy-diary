<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Diary</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-secondary navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">MyDairy</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/member/signup">회원가입</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/diary/register">다이어리등록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/diary/list">다이어리목록</a>
        </li>    
      </ul>
    </div>
  </div>
</nav>
</body>
</html>