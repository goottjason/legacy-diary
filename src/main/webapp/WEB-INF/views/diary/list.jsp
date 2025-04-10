<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>다이어리목록</title>
<script type="text/javascript">
	// .finishedCheckbox
$(function() {
	
	$(".finishedCheckbox").change(function() {
		
		let dno = $(this).data("dno");
		let checked = $(this).is(":checked");
		console.log(dno, checked); // 체크되면 true, 언체크면 false
		
		$.ajax({
			url: "/diary/updateFinished", // 데이터가 송수신될 서버의 주소
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			data: { // 보낼 데이터
				"dno": dno,
				"finished" : checked
			},
			dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
			// async: false, // 동기 통신 방식
			success: function (data) {
				// 통신이 성공하면 수행할 함수
				console.log(data); // 데이터가 넘어오면 콘솔에 확인
				if (checked) {
					console.log("체크되었으므로 가운데 줄 그을 클래스를 넣는다.", dno);
					console.log($(this).find("label"));
// 					$(this).next().next().addClass("checkon");
				} else {
					console.log("체크해제됐으므로 가운데 줄 그을 클래스를 제거한다.", dno);
					$(this).next().next().removeClass("checkon");
				}
			},
			error: function () {},
			complete: function () {},
		});
	});
	
});
	
</script>
<style>
	.checkon {
		color:red;
	}
</style>
</head>
<body>
	<!-- include지시자 or 액션태그 -->
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container mt-5">
  		<div class="row">
	
			<h1>다이어리목록</h1>
<%-- 			<div>${diaryList }</div> --%>
			<div>
				  <ul class="list-group">
				  	<c:forEach var="diary" items="${diaryList}">
					    <li class="list-group-item">
					    	<!-- 체크박스 -->
					    	<input type = "checkbox" class="form-check-input finishedCheckbox" data-dno="${diary.dno}"
					    	<c:if test="${diary.finished}">checked</c:if>>
					    	<label class="form-check-label" for="check1" data-dno="${diary.dno}">${diary.title}</label>
							<span>  (${diary.dueDate})</span>
					    </li>
				  	</c:forEach>
				  </ul>
			</div>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>