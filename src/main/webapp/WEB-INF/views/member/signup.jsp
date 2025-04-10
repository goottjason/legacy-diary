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
	$("#memberName").on("blur", function() {
		console.log($("#memberName").val());
		if($("#memberName").val().length > 0) { // 
			outputError("사용가능", $("#memberName"), "green");
			$("#nameValid").val("checked");
		} else {
			outputError("이름은 필수 입력입니다.", $("#memberName"), "red");
			$("#nameValid").val("");
		}		
	});
	
	$("#memberId").on("blur", function () {
		let tmpMemberId = $("#memberId").val();
		console.log(tmpMemberId);
		// 아이디 : 필수 & 중복 불가 & 길이(4~8자)
		if (tmpMemberId.length > 0) {
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
		} else {
			outputError("아이디는 필수항목입니다.", $("#memberId"), "red");
		}
	});
	
	
	// 비밀번호 체크 이벤트
	$("#memberPwd1").on("blur", function () {
		// 비밀번호 4~8자
		let tmpPwd = $("#memberPwd1").val();
		if (tmpPwd.length < 4 || tmpPwd.length > 8) {
			outputError("비밀번호는 4~8자로 입력하세요!", $("#memberPwd1"), "red");
// 			$("#memberPwd1").val("");
// 			$("#memberPwd1").focus();
			$("#pwdValid").val("");
		} else {
			let tmpPwd1 = $("#memberPwd1").val();
			let tmpPwd2 = $("#memberPwd2").val();
			if(tmpPwd2 == "") {
				outputError("아래에 다시 한번 입력해주세요.", $("#memberPwd1"), "orange");
			} else {
				if(tmpPwd1 != tmpPwd2) {
					outputError("비밀번호가 일치하지 않습니다.", $("#memberPwd1"), "red");
					outputError("", $("#memberPwd2"), "red");
					$("#pwdValid").val("");
				} else {
					outputError("비밀번호 검증완료", $("#memberPwd1"), "green");
					outputError("비밀번호가 일치합니다.", $("#memberPwd2"), "green");
					$("#pwdValid").val("checked");
				}		
			}
		}
	});
	
	$("#memberPwd2").on("blur", function() {
		let tmpPwd1 = $("#memberPwd1").val();
		let tmpPwd2 = $("#memberPwd2").val();
		if (tmpPwd1.length < 4 || tmpPwd1.length > 8) {
			return;
		}
		if(tmpPwd1 != tmpPwd2) { // 
			outputError("비밀번호가 일치하지 않습니다.", $("#memberPwd1"), "red");
			outputError("", $("#memberPwd2"), "red");
			$("#pwdValid").val("");
		} else {
			outputError("비밀번호 검증완료", $("#memberPwd1"), "green");
			outputError("비밀번호가 일치합니다.", $("#memberPwd2"), "green");
			$("#pwdValid").val("checked");
		}
	});
	
	$("#memberEmail").on("blur", function() {
		
		if($("#memberEmail").val().length > 0) { // 
			checkEmail();
		} else {
			outputError("이메일은 필수항목입니다.", $("#memberEmail"), "red");
		}
	});
	
	
});

function checkEmail() {
	// alert("checkEmail");
	// 1) 정규표현식을 이용하여 이메일 주소 형식인지 아닌지 판단
	// 2) 이메일 주소 형식이면, 인증번호를 이메일로 보내고 
	// 인증번호를 입력받을 태그를 보여주고 다시 입력받아서 
	// 보낸 인증번호와 유저가 입력한 인증번호가 일치하는지 검증
	let tmpMemberEmail = $("#memberEmail").val();
	let emailRegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (!emailRegExp.test(tmpMemberEmail)) {
		outputError("이메일 형식으로 다시 작성해주세요.", $("#memberEmail"), "red");
	} else {
		outputError("올바른 이메일 형식입니다.", $("#memberEmail"), "green");
		callSendEmail(); // 이메일을 발송하는 함수를 호출
	}
}

function callSendEmail() {
	$.ajax({
		url: "/member/callSendEmail", // 데이터가 송수신될 서버의 주소
		type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		data: { // 보낼 데이터
			"tmpMemberEmail": $("#memberEmail").val()
		},
		dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
		// async: false, // 동기 통신 방식
		success: function (data) {
			// 통신이 성공하면 수행할 함수
			console.log(data); // 데이터가 넘어오면 콘솔에 확인

			// 멤버의 이메일주소로 인증메일을 보내는 것까지 성공하게 되면, success!
			if (data == "success") {
				// 인증번호 입력받을 수 있는 div요소를 생성
// 				alert("이메일로 인증번호를 발송했습니다. 인증코드를 입력해주세요.");
				if ($(".autenticationDiv").length == 0) {		
					showAuthenticateDiv(); // 인증번호를 입력받을 태그요소를 출력
				}
				startTimer(); // 타이머 동작을 호출
				
				
			}
		},
		error: function () {},
		complete: function () {},
	});
}

let timeLeft = 180; // 초단위
let intervalId = null;

function startTimer() {
	// 3분(180초)부터 줄어가야 함
	// setInterval 
	clearTimer();
	timeLeft = 180;
	updateDisplay(timeLeft);
	intervalId = setInterval(function() {
		timeLeft--;
		updateDisplay(timeLeft);
		if (timeLeft <= 0) {
			// 타이머 종료
			clearTimer();
			expiredTimer();
		}
	}, 1000); // 밀리초이므로 1초 = 1000
	
}

function expiredTimer() {
	// 인증버튼 비활성화
	$("#authBtn").prop("disabled", true);
	
	
	// 타이머 종료시, 백엔드에도 인증시간이 만료되었음을 알려야 한다.
	if($("#emailValid").val() != "checked") {
		
		$.ajax({
			url: "/member/clearAuthCode", // 데이터가 송수신될 서버의 주소
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			// 보낼 데이터는 필요 없음
			dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
			// async: false, // 동기 통신 방식
			success: function (data) {
				// 통신이 성공하면 수행할 함수
				console.log(data); // 데이터가 넘어오면 콘솔에 확인
				alert("인증시간이 만료되었습니다. 재인증해주세요");
				$(".autenticationDiv").remove();
				$("#memberEmail").val("").focus();
			},
			error: function () {},
			complete: function () {},
		});
	}
}

function clearTimer() {
	if (intervalId != null) {		
		clearInterval(intervalId); // ID값을 전달하여 setInterval을 클리어할 수 있음
		intervalId = null; // 다시 초기세팅하듯이 돌려놓음
	}
}

function updateDisplay(seconds) {
	// 시간출력
	let min = Math.floor(seconds/60);
	let sec = String(seconds % 60).padStart(2, "0"); // 2자리인데 남은 부분은 왼쪽에 0으로 채워주는 메서드
	// console.log(min + " : " + sec);
	let remainTime = min + ":" + sec;
	$(".timer").html(remainTime);
}


function showAuthenticateDiv() {
	let authDiv = `
		<div class="autenticationDiv mt-2">
			<input type="text" class="form-control" id="memberAuthCode" placeholder="인증번호를 입력하세요." />
			<div class="d-flex align-items-center">
				<span class="timer">3:00</span>
			</div>
			<button type="button" id="authBtn" class="btn btn-info" onclick="checkAuthCode();">인증하기</button> 
		</div>
	`;
	$(authDiv).insertAfter("#memberEmail");
	
}









// 인증하기 버튼을 눌렀을 때 실행되는 함수
function checkAuthCode() {
	// 유저가 입력한 인증번호를 가져옴
	let memberAuthCode = $("#memberAuthCode").val();
	$.ajax({
		url: "/member/checkAuthCode", // 데이터가 송수신될 서버의 주소
		type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		data: { // 보낼 데이터
			"memberAuthCode": memberAuthCode
		},
		dataType: "text", // 수신받을 데이터 타입 (MIME TYPE) (text, json, xml)
		// async: false, // 동기 통신 방식
		success: function (data) {
			// 통신이 성공하면 수행할 함수
			console.log(data); // 데이터가 넘어오면 콘솔에 확인
			if (data == "success") {
				// 일치하여 
				outputError("인증완료", $("#memberEmail"), "blue");
				$(".autenticationDiv").remove();
				$("#emailValid").val("checked");				
			} else {
				outputError("인증번호가 일치하지 않습니다. 다시 입력해주세요.", $("#memberEmail"), "red");
				$("#emailValid").val("checked");				
			}
			
		},
		error: function () {},
		complete: function () {},
	});
}

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

function pwdValid() {
	let result = false;
	
	if ($("#pwdValid").val() == "checked") {
		result = true;
	}
	return result;
}

function emailValid() {
	let result = false;
	
	if ($("#emailValid").val() == "checked") {
		result = true;
	}
	return result;
}

function nameValid() {
	let result = false;
	
	if ($("#nameValid").val() == "checked") {
		result = true;
	}
	return result;
}

function isValid() {
	let result = false;
	let idCheck = idValid();
	let pwdCheck = pwdValid();
	let emailCheck = emailValid();
	let nameCheck = nameValid();
	console.log(idCheck, pwdCheck, emailCheck, nameCheck);
	if (idCheck && pwdCheck && emailCheck && nameCheck) {
		result = true;
	}
	return result; // 폼이 전송되지 않도록 false 반환...
}
</script>
<style>
	.timer { color: red }
</style>

</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">
			<h1>회 원 가 입</h1>
			<form action="signup" method="POST">
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
					<input type="hidden" id="emailValid" />
				</div> 
				<div class="mb-3 mt-3">
					<label for="memberName">이름 :&nbsp;&nbsp;</label><span></span>
					<input type="text" class="form-control" id="memberName" placeholder="Enter your name" name="memberName">
					<input type="hidden" id="nameValid" />
				</div>
				<button type="submit" class="btn btn-success" onclick="return isValid();">가입하기</button>
				<button type="submit" class="btn btn-danger">취소</button>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>