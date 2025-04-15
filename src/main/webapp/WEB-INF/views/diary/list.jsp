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
	$("#searchBtn").click(function() {   
	    $("#searchFormCard").toggle();
	  });
  
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
        
        if (data =='success') {
          if(checked) {
            $("#dlist-"+dno).addClass("completed");
          } else {
            $("#dlist-"+dno).removeClass("completed");
          }
          self.location='/diary/list';
        }
//         if (checked) {
//           console.log("체크되었으므로 가운데 줄 그을 클래스를 넣는다.", dno);
//           console.log($(this).next());
// //           $(this).next().next().addClass("checkon");
//         } else {
//           console.log("체크해제됐으므로 가운데 줄 그을 클래스를 제거한다.", dno);
//           $(this).next().next().removeClass("checkon");
//         }
      },
      error: function () {},
      complete: function () {},
    });
  });
  $(".modifyBtn").click(function() {
    let dno = $(this).data("dno");
    let title = $(this).data("title");
    let date = $(this).data("date");
    console.log(dno, title, date);
    
    $("#modifyDno").val(dno);
    $("#modifyTitle").val(title);
    $("#modifyDueDate").val(date);
    
    
    $("#modifyModal").show();
    
  });
  $(".closeModal").click(function() {
    $("#modifyModal").hide();
  })
});

// 수정한 부분을 읽어오기
function modifyDiary() {
  let dno = $("#modifyDno").val();
  let title = $("#modifyTitle").val();
  let dueDateStr = $("#modifyDueDate").val();
  console.log(dno, title, dueDateStr);
  // 유효성검사
  if (title == "" || dueDateStr =="") {
    alert("제목, 날짜를 입력하세요");
    return;
  }
  
  // 수정 요청
  $.ajax({
    url: "/diary/modify", // 데이터가 송수신될 서버의 주소
    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
    data: { // 보낼 데이터
      dno: dno,
      title: title,
      dueDateStr: dueDateStr
    },
    dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
    // async: false, // 동기 통신 방식
    success: function (data) {
      // 통신이 성공하면 수행할 함수
      console.log(data); // 데이터가 넘어오면 콘솔에 확인
      $("#modifyModal").hide();
      self.location='/diary/list';
      
    },
    error: function () {},
    complete: function () {},
  });  
  
  
  
}
  
  
</script>
<style>
  .checkon {
    color:red;
  }
  li.completed .titleDiv,
  li.completed .dueDateDiv {
    text-decoration : line-through;
    color : gray;
  }
</style>
</head>
<body>
  <!-- include지시자 or 액션태그 -->
  <jsp:include page="../header.jsp"></jsp:include>
  
  <div class="container mt-5">
    <div class="row">

    <h1>다이어리목록</h1>
    <div class="mb-3">
      <button class="btn btn-primary" id="searchBtn">🔎</button>
    </div>
    <div class="card" id="searchFormCard" style="display:none;">
      <div class="card-body">
        <form action="/diary/search" method="POST">
          <div class="mb-3 mt-3">
            <label for="searchWord" class="form-label">제목 검색 : </label>
            <input type="text" class="form-control" id="searchWord" placeholder="검색어" name="searchWord">
            <input type="hidden" name="searchTypes" value="title" />
          </div>
          <div>
            <label for="finishedSelect" class="form-label">완료여부 (select one):</label>
            <select class="form-select" id="finishedSelect" name="finished">
              <option value="">모두보기</option>
              <option value="0">미완료</option>
              <option value="1">완료</option>
            </select>
          </div>
          <div>
            <label for="from" class="form-label">dueDate From </label>
            <input type="date" class="form-control" id="from" name="from">
          </div>
          <div>
            <label for="to" class="form-label">dueDate To </label>
            <input type="date" class="form-control" id="to" name="to">
          </div>
          <div>
            <button type="submit" class="btn btn-warning">검색</button>
          </div>
        </form>
      </div>
    </div>

<%--       <div>${diaryList }</div> --%>
    <div>
      <ul class="list-group">
        <c:forEach var="diary" items="${diaryList }">
          <li class="list-group-item d-flex align-items-center ${diary.finished ? 'completed' : '' }" id = "dlist-${diary.dno}">
            <!-- 체크박스 -->
            <input type = "checkbox" class="form-check-input finishedCheckbox" data-dno="${diary.dno}"
            <c:if test="${diary.finished}">checked</c:if>>
            <div class="titleDiv">${diary.title}</div>
            <div class="dueDateDiv">  (${diary.dueDate})</div>
          <button type="button" class="btn btn-outline-info btn-sm modifyBtn"
          data-dno="${diary.dno }" data-title="${diary.title}" data-date="${diary.dueDate}">수정</button>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
  </div>
  
  
  
  
  
  
  <!-- The Modal -->
<div class="modal" id="modifyModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="btn-close closeModal" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <input type="hidden" id="modifyDno" name="dno" />
        <div class="mb-3 mt-3">
        <label for="modifyTitle" class="form-label">Title :&nbsp;&nbsp;</label><span></span>
    <span id="titleError"></span>
    <input type="text" class="form-control" id="modifyTitle" placeholder="제목" name="title">
    </div>
    
    <div class="mb-3 mt-3">
          <label for="modifyDueDate" class="form-label">dueDate :&nbsp;&nbsp;</label><span></span>
          <span id="dueDateError"></span>
          <input type="date" class="form-control" id="modifyDueDate" name="dueDateStr">
        </div>
    
    
    
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-success" onclick="modifyDiary();">저장</button>
        <button type="button" class="btn btn-danger closeModal" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
  
  
  
  
  
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>