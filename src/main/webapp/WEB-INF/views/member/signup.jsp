<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">


$(function() {
	// 하여 통과되면 checked로 바꾸고 checkd되면...? 순서 헷갈림...
	// 아이디 이벤트
	// 키업 이벤트 발생시
	$("#memberId").on("blur", function () {
		let tmpMemberId = $("#memberId").val();
		console.log(tmpMemberId);
		// 아이디 : 필수 & 중복 불가 & 길이(4~8자)
		if (tmpMemberId.length < 4 || tmpMemberId.length > 8) {
			outputError("아이디는 4~8자로 입력하세요!", $("#memberId"), "red");
			$("#idValid").val("");
		} else {
			// 아이디 중복 체크 (같은 페이지 내에서 요청을 보내고 받으려면, ajax가 필요함)	
			$.ajax({
				url: "/member/isDuplicate", // 데이터가 송수신될 서버의 주소
				type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
				data: { // 보낼 데이터
					"tmpMemberId": tmpMemberId
				},
				dataType: "json", // 수신받을 데이터 타입 (MIME TYPE)
				// async: false, // 동기 통신 방식
				success: function (data) {
					// 통신이 성공하면 수행할 함수
					console.log(data); // 데이터가 넘어오면 콘솔에 확인
					if (data.msg == "duplicate") { 
						outputError("중복된 아이디입니다. 다시 입력해주세요.", $("#memberId"), "red");
						$("#memberId").focus(); // 다시 커서 가도록 함
						$("#idValid").val("");
					} else if (data.msg == "not duplicate") {
						outputError("사용 가능한 아이디입니다.", $("#memberId"), "green");	
						$("#idValid").val("checked");
					}
				},
				error: function () {},
				complete: function () {},
			});			
		}
	});
	
	
	// 비밀번호 체크 이벤트
	$("#memberPwd1").on("blur", function () {
		// 비밀번호 4~8자
		let tmpPwd = $("#memberPwd1").val();
		if (tmpPwd.length < 4 || tmpPwd.length > 8) {
			outputError("비밀번호는 4~8자로 입력하세요!", $("#memberPwd1"), "red");
			$("#memberPwd1").val("");
			$("#memberPwd1").focus();
			$("#pwdValid").val("");
		} else {
			outputError("사용가능한 비밀번호입니다.", $("#memberPwd1"), "green");
		}
	});
	
	$("#memberPwd2").on("blur", function() {
		let tmpPwd1 = $("#memberPwd1").val();
		let tmpPwd2 = $("#memberPwd2").val();
		if (tmpPwd1.length < 4 || tmpPwd1.length > 8) {
			return;
		}
		if(tmpPwd1 != tmpPwd2) { // 
			outputError("", $("#memberPwd1"), "red");
			outputError("위와 동일한 비밀번호를 입력해주세요.", $("#memberPwd2"), "red");
// 			$("#memberPwd1").val("");
			$("#memberPwd2").val("");
			$("#memberPwd2").focus();
			$("#pwdValid").val("");
		} else {
			outputError("비밀번호 검증완료", $("#memberPwd1"), "green");
			outputError("비밀번호가 일치합니다.", $("#memberPwd2"), "green");
			$("#pwdValid").val("checked");
		}
	});
	
});


function outputError(errorMsg, tagObj, color) {
	// input요소 넘어오면, 그 이전 요소를 잡아준다. (span)
	let errTag = $(tagObj).prev();
	$(errTag).html(errorMsg);
	$(errTag).css("color", color); // 인라인으로 첨부됨
	$(tagObj).css("border-color", color);
}

function idValid() {
	let result = false;
	
	if ($("#idValid").val() == "checked") {
		result = true;
	}
	return result;
}

function isValid() {
	let result = false;
	let idCheck = idValid();
	let pwdCheck = pwdValid();
	
	
	return result; // 폼이 전송되지 않도록 false 반환...
}
</script>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">
			<h1>회 원 가 입</h1>
			<form action="/signup" method="POST">
				<div class="mb-3 mt-3">
					<label for="memberId">아이디 :&nbsp;&nbsp;</label><span></span>
					<input type="text" class="form-control" id="memberId" placeholder="Enter ID" name="memberId">
					<input type="hidden" id="idValid" />
				</div>
				<div class="mb-3">
					<label for="memberPwd1">비밀번호 :&nbsp;&nbsp;</label><span></span>
					<input type="password" class="form-control" id="memberPwd1" placeholder="Enter password" name="memberPwd">
				</div>
				<div class="mb-3">
					<label for="memberPwd2">비밀번호 재입력 :&nbsp;&nbsp;</label><span></span>
					<input type="password" class="form-control" id="memberPwd2" placeholder="Enter password again">
					<input type="hidden" id="pwdValid" />
				</div>
				
				<div class="mb-3 mt-3">
					<label for="memberEmail">이메일 :&nbsp;&nbsp;</label><span></span>
					<input type="email" class="form-control" id="memberEmail" placeholder="Enter email" name="memberEmail">
				</div> 
				<div class="mb-3 mt-3">
					<label for="memberName">이름 :&nbsp;&nbsp;</label><span></span>
					<input type="text" class="form-control" id="memberName" placeholder="Enter your name" name="memberName">
				</div>
				<button type="submit" class="btn btn-success" onclick="return isValid();">가입하기</button>
				<button type="submit" class="btn btn-danger">취소</button>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>