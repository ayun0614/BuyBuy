<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  function sample6_execDaumPostcode() {
      new daum.Postcode({
          oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var addr = ''; // 주소 변수
              var extraAddr = ''; // 참고항목 변수

              //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
              if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                  addr = data.roadAddress;
              } else { // 사용자가 지번 주소를 선택했을 경우(J)
                  addr = data.jibunAddress;
              }

              // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
              if(data.userSelectedType === 'R'){
                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                      extraAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if(extraAddr !== ''){
                      extraAddr = ' (' + extraAddr + ')';
                  }
                  // 조합된 참고항목을 해당 필드에 넣는다.
                  document.getElementById("sample6_extraAddress").value = extraAddr;
              
              } else {
                  document.getElementById("sample6_extraAddress").value = '';
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('sample6_postcode').value = data.zonecode;
              document.getElementById("sample6_address").value = addr;
              // 커서를 상세주소 필드로 이동한다.
              document.getElementById("sample6_detailAddress").focus();
          }
      }).open();
  }
  </script>
  <script>
   $(document).ready(function(){
	  $("#sample6_extraAddress").hide();
   })
  </script>
  <style>
h2 {
	text-align: center;
}

.panel {
	margin-top: 50px;
}

.form-group {
	margin-bottom: 20px;
}

.btn-submit {
	width: 100px;
}

/* 추가한 스타일 */
.address-group {
	display: flex;
	align-items: center;
}

.address-field {
	flex: 1;
	margin-right: 10px;
}

.btn-find-address {
	margin-top: 5px;
}

div.main {
	position: relative;
	padding: 20px;
}

div .  input {
	width: 300px;
	height: 30px;
	background-color: black;
	border: 0;
	color: white;
	text-indent: 10px;
}

div.main i {
	position: absolute;
	left: 75%;
	top: 27px;
	color: orange;
}
.input {
  position: relative;
}

.input .eyes {
  position: absolute;
  top: 0;
  bottom: 0;
  right: 0;
  margin: auto 2px;
  height: 30px;
  font-size: 22px;
  cursor: pointer;
}
</style>
  
<script type="text/javascript">
$(document).ready(function(){
	if(${!empty msgType}){
 		$("#messageType").attr("class", "modal-content panel-warning");    
		$("#myMessage").modal("show");
	}
});


function registerCheck(){
       var member_id=$("#member_id").val();
       $.ajax({
    	   url : "$registerCheck",
    	   type : "get",
    	   data : { "member_id" : member_id},
    	   success : function(result){
        		   if(result==1){
        			  $("#checkMessage").html("사용할 수 있는 아이디입니다.");			  
        		   }else{
         			  $("#checkMessage").html("사용할 수 없는 아이디입니다.");
         			  
        		   }
        	 		$("#myModal").modal("show");
    	   },    	   
    	   error : function(){ 
    		   alert("error"); 
    	   }    	   
       });    	
    }  
   
    

    
   
    
    
    
  </script>
</head>
<body>
<div class="container">
  <jsp:include page="../include/header.jsp"/> 
  <h2></h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
<form action="${contextPath }/account/insert" method="post">
						<div class="form-group">
							<label for="name">이름</label> <input id="name" name="name"
								class="form-control" type="text" maxlength="20"
								placeholder="이름을 입력하세요." value="${mvo.Member_ID}">
						</div>
						<div class="form-group">
							<label for="member_id">아이디</label> <input id="member_id"
								name="member_id" class="form-control" maxlength="20"
								placeholder="아이디를 입력하세요.">
		<td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td>
						</div>
            
	<div class="form-group">
	<label for="Password">비밀번호 </label> <input id="password"	
								name="password" class="form-control" type="password"
								maxlength="20" placeholder="비밀번호를 입력하세요." value="${mvo.name}"> <span class="glyphicon glyphicon-eye-open"></span> <!-- 아이콘 추가 -->
        </span>
           
    </div>

						<div class="form-group">
							<label for="password2">비밀번호 확인</label> <input id="password2"
								name="password2" class="form-control" type="password"
								maxlength="20" placeholder="비밀번호를 입력하세요." value="${mvo.name}">
						</div>
						<div class="form-group">
							<label for="Phone">전화번호</label> <input id="Phone" name="Phone"
								type="text" class="form-control" oninput="oninputPhone(this)"
								maxlength="20" placeholder="전화번호를 입력하세요">
						</div>
		
 <div class="form-group">
      <label for="address">주소</label>
      <div class="address-group">
        <div class="address-field">
          <input type="text" id="sample6_postcode" class="form-control" name="addr" placeholder="우편번호">
        </div>
        <div class="btn-find-address">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
        </div>
      </div>
      <div class="address-field">
        <input type="text" id="sample6_address" name="addr"class="form-control" placeholder="주소">
      </div>
      <div class="address-field">
        <input type="text" id="sample6_detailAddress" name="addr"class="form-control" placeholder="상세주소">
      </div>
      <div class="address-field">
        <input type="text" id="sample6_extraAddress" name="addr"class="form-control" placeholder="참고항목" >
      </div>
    </div>

  
    </td>
</tr>

						<div class="form-group">
							<tr height="50">

								<div style="width: 1100px; margin: 0 auto;">
									<input type="submit" maxlength="20" value="회원가입"
										class="btn btn-primary btn-block">
								</div>
					</form>  
    </div>
     <!--  다이얼로그창(모달) -->
    <!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog" >
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title"></h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
	        <h4 class="modal-title">${msgType}</h4>
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
