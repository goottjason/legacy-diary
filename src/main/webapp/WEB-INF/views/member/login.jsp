<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- include지시자 or 액션태그 -->
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container mt-5">
  		<div class="row">
	
			<h1>로그인</h1>
			<form action="login" method="POST">
			  <div class="mb-3 mt-3">
			    <label for="memberId" class="form-label">아이디 :</label>
			    <input type="text" class="form-control" id="memberId" placeholder="Enter memberId" name="memberId">
			  </div>
			  <div class="mb-3">
			    <label for="memberPwd" class="form-label">Password:</label>
			    <input type="password" class="form-control" id="memberPwd" placeholder="Enter password" name="memberPwd">
			  </div>
			  <button type="submit" class="btn btn-primary">로그인</button>
			  <button type="reset" class="btn btn-secondary">취소</button>
			</form>
						
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>