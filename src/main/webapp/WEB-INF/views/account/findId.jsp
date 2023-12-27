<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<scrist
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
		<script>
		
		function showSuccessModal(result) {
		    if (result === "error") {
		        $('#messageType').removeClass('panel-success').addClass('panel-danger');
		        $('#msgType').text('실패');
		        $('#msg').text('아이디를 찾을 수 없습니다.');
		        $('#idModal').modal('hide'); // Hide the success modal
		        $('#myMessage').modal('show');
		    } else {
		        $('#findId').text(result);
		        $('#idModal').modal('show');
		    }
		}



		$(document).ready(function() {   
		    $('.findIdBtn').click(function() {
		        var name = $('#name').val();
		        var email = $('#email').val();
		        
		        $('#idModal').modal('hide');

		        $.ajax({
		            url: '${contextPath}/account/findMemberId?name=' + name + '&email=' + email,
		            type: 'get',
		            success: function(result) {
		                showSuccessModal(result);
		            },
		            error: function() {
		                $('#messageType').removeClass('panel-success').addClass('panel-danger');
		                $('#msgType').text('에러');
		                $('#msg').text('아이디를 찾을 수 없습니다.'); // Set the specific error message here
		                $('#idModal').modal('hide'); // Hide the success modal
		                $('#myMessage').modal('show');
		            }

		        });
		    });

		    $('#idButton').click(function() {
		        $('#idForm').show();
		        $('#passwordForm').hide();
		        $('#idModal').modal('hide');
		    });

		    $('#passwordButton').click(function() {
		        $('#idForm').hide();
		        $('#passwordForm').show();
		        $('#idModal').modal('hide');
		    });
		});
		
		

		</script>
<style>

#idForm {
    margin-top: 175px;
    margin-right: auto;
    margin-left: auto;
    padding: 40px; /* 여백을 크게 조정 */
    width: 90%; /* 전체 크기를 90%로 조정 */
    max-width: 600px; /* 최대 너비 설정 */
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);

}

h3 {
    text-align: center;
    margin-bottom: 30px; /* 제목과의 간격을 늘림 */
    color: #333;
    font-size: 28px; /* 제목 크기 키우기 */
}

.form-group {
    margin-bottom: 30px; /* 각 입력란 간격 늘리기 */
}

label {
    font-weight: bold;
    font-size: 18px; /* 라벨 폰트 크기 키우기 */
}

.form-control {
    border-radius: 5px;
    border: 1px solid #ccc;
    padding: 15px; /* 입력란 내용과의 간격 늘리기 */
    width: calc(100% - 32px);
    font-size: 16px; /* 입력 내용 폰트 크기 키우기 */
}

.btn-primary {
    border-radius: 20px;
    background-color: #007bff;
    color: white;
    padding: 15px 20px; /* 버튼 내용과의 간격 늘리기 */
    border: none;
    cursor: pointer;
    display: block;
    width: 100%;
    margin-top: 20px; /* 버튼과의 간격 늘리기 */
    font-weight: bold;
    font-size: 18px; /* 버튼 폰트 크기 키우기 */
}

.btn-primary:hover {
    background-color: #0056b3;
}

.btn-link {
    text-align: center;
    display: block;
    margin-top: 20px; /* 링크와의 간격 늘리기 */
    font-weight: bold;
    font-size: 18px; /* 링크 폰트 크기 키우기 */
}

.modal-content {
    border-radius: 10px;
}

.modal-header {
    background-color: #007bff;
    color: white;
    border-radius: 10px 10px 0 0;
}

.modal-footer {
    border-radius: 0 0 10px 10px;
}

.modal-title {
    font-weight: bold;
    color: white;
    font-size: 24px; /* 모달 제목 크기 키우기 */
}


</style>

</head>
<body>
   <jsp:include page="../include/header.jsp" />
	<div class="container" style="max-width:900px;"> <!-- 최대 폭을 600px로 설정 -->
    <div class="mt-3" id="idForm" style="display: block;">
      
        <form id="idRelatedForm" action="${contextPath}/account/findId" method="post">
            <div class="form-group">
              <h3>아이디 찾기</h3>
                <label for="name">이름</label>
                <input id="name" name="name" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요." onkeyup="nameCheck()">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input id="email" name="email" class="form-control" type="text" title="이메일 주소를 입력해주세요." required placeholder="이메일 주소를 입력하세요.">
            </div>
            <button type="button" class="btn btn-primary mt-2 findIdBtn" data-toggle="modal">아이디 찾기</button>
            <a href="${contextPath}/account/findPw" class="btn btn-link mt-2">비밀번호 찾기 페이지로 이동</a>
        </form>
    </div>
    <div class="modal fade" id="idModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">아이디 찾기 결과</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="findId">찾으시는 아이디입니다.</p>
                    <p id="notFoundMessage"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
     <!-- 실패 메세지를 출력(modal) -->
    <div id="myMessage" class="modal fade" role="dialog"> 
     <div class="modal-dialog">   
       <!-- Modal content-->
       <div id="messageType" class="modal-content panel-info">
         <div class="modal-header panel-heading">
       
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">아이디를 찾을수 없습니다</h4>
         </div>
         <div class="modal-body">
           <p>${msg}</p>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>   
     </div>
   </div>    
  </div>
</div>
</body>
</html>
</body>
</html>