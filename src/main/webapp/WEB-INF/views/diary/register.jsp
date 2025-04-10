<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>다이어리등록</title>

<script type="text/javascript">

$(function() {
	$("#title").on("blur", function() {
		validTitle();
	});
	
	$("#dueDate").on("blur", function() {
		validDueDate();
	});
	
	$("#writer").on("blur", function() {
		validWriter();
	})
});


function validDueDate() {
	// 완료일(오늘 이후의 날만 유효)
	// 필수
	let result = false;
	let dueDate = $("#dueDate").val(); // 2025-04-10
	console.log(dueDate);
	let today = new Date().toISOString().split("T")[0];
	console.log(today);
	
	if (dueDate == "") {
		$("#dueDateError").html("완료일은 필수항목입니다.");		
	} else if (new Date(dueDate) - new Date() < 0) {
		$("#dueDateError").html("완료일은 오늘 이후로");		
	} else {
		$("#dueDateError").html("");
		result = true;
	}
	return result;
}

function validTitle() {
	// 필수, 100자 제한
	let result = false;
	let title = $("#title").val();
	if (title == '') {
		$("#titleError").html("제목을 입력하세요");
	} else {
		console.log(title.length);
		if (title.length > 100) {
			$("#titleError").html("100자를 초과할 수 없습니다.");
		} else {
			$("#titleError").html("");
			result = true;
		}
	}
	return result;
}

function validWriter() {
	let result = false;
	let writer = $("#writer").val();
	if (writer == '') {
		$("#writerError").html("작성자는 필수");
	} else {
		$("#writerError").html("");
		result = true;
	}
	return result;
}


function isValid() {
	let result = false;
	let titleValid = validTitle();
	let dueDateValid = validDueDate();
	let writerValid = validWriter();
	console.log(titleValid, dueDateValid, writerValid);
	if (titleValid && dueDateValid && writerValid) {
		result = true;
	}
	return result;
}

function clearErrors() {
	$("#titleError").html("");
	$("#dueDateError").html("");
	$("#writerError").html("");
}

</script>

</head>
<body>
	<!-- include지시자 or 액션태그 -->
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container mt-5">
  		<div class="row">
	
			<h1>다이어리등록</h1>
			<form action="/diary/register" method="post">
				<div class="mb-3 mt-3">
					<label for="title" class="form-label">Title :&nbsp;&nbsp;</label><span></span>
					<span id="titleError"></span>
					<input type="text" class="form-control" id="title" placeholder="제목" name="title">
				</div>
				<div class="mb-3 mt-3">
					<label for="dueDate" class="form-label">dueDate :&nbsp;&nbsp;</label><span></span>
					<span id="dueDateError"></span>
					<input type="date" class="form-control" id="dueDate" name="dueDateStr">
				</div>
				<div class="mb-3 mt-3">
					<label for="writer" class="form-label">writer :&nbsp;&nbsp;</label><span></span>
					<span id="writerError"></span>
					<input type="text" class="form-control" id="writer" placeholder="작성자" name="writer">
				</div>
				<button type="submit" class="btn btn-success" onclick="return isValid();">Submit</button>
				<button type="reset" class="btn btn-danger" onclick="clearErrors();">취소</button>
			</form>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>