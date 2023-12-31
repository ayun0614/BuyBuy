<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
              document.getElementById("zipcode").value = data.zonecode;
              document.getElementById("addr").value = addr;
              // 커서를 상세주소 필드로 이동한다.
              document.getElementById("detailaddr").focus();
          }
      }).open();
  }

$(document).ready(function(){
   $("#sample6_extraAddress").hide();
   if(${!empty msgType}){
       $("#messageType").attr("class", "modal-content panel-warning");    
      $("#myMessage").modal("show");
   }
});

function passwordCheck() {
    var memPass1 = $("#password").val();
    var memPass2 = $("#password2").val();

    if (memPass1 !== memPass2) {
        $("#passMessage").html("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
    } else {
        $("#passMessage").html("");
        $("#memPassword").val(memPass1);
    }
}


function validateForm() {
   var nickname = document.getElementById("nickname").value;
    var password = document.getElementById("password").value;
    var password2 = document.getElementById("password2").value;
    var phone = document.getElementById("phone").value;
    var zipcode = document.getElementById("zipcode").value;
    var addr = document.getElementById("addr").value;
    var detailaddr = document.getElementById("detailaddr").value;

    if (nickname === "" || password === "" || phone === "" || zipcode === "" || addr === "" || detailaddr === "") {
        alert("모든 필수 항목을 작성해주세요.");
        return false; // 회원가입 제한
    }
    if (password !== password2) {
        alert("비밀번호가 일치하지 않습니다");
        return false;
    }
    
}


function autoHyphen2(target) {
     target.value = target.value
       .replace(/[^0-9]/g, '')
       .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3")
       .replace(/(\-{1,2})$/g, "");
   }
   
function previewImages(input) {
    var previewContainer = document.getElementById('imagePreviewContainer');
    var files = input.files;

    for (var i = 0; i < files.length; i++) {
       var reader = new FileReader();
       var file = files[i];

       reader.onloadend = (function (index) {
          return function () {
             var img = document.createElement('img');
             img.src = reader.result;
             img.className = 'preview-image';
             img.style.width = '800px';
             img.style.height = '500px';
             previewContainer.appendChild(img);

            

     
          };
       })(i);

       if (file) {
          reader.readAsDataURL(file);
       }
    }

    // 이미지 추가 버튼을 숨김
    document.getElementById('imageUploadBtn').style.display = 'none';
 }
function togglePassword() {
    var passwordField = document.getElementById("password");
    var toggleIcon = document.getElementById("togglePassword");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        toggleIcon.className = "glyphicon glyphicon-eye-open";
    } else {
        passwordField.type = "password";
        toggleIcon.className = "glyphicon glyphicon-eye-close";
    }
}
function togglePassword2() {
    var passwordField = document.getElementById("password2");
    var toggleIcon = document.getElementById("togglePassword2");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        toggleIcon.className = "glyphicon glyphicon-eye-open";
    } else {
        passwordField.type = "password";
        toggleIcon.className = "glyphicon glyphicon-eye-close";
    }
}
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

div . input {
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
</head>
<body>
   <jsp:include page="../include/header.jsp" />
   <div class="container">
      <div class="panel panel-default">
         <form method="post" enctype="multipart/form-data" action="${contextPath}/account/membermodify?member_id=${mvo.member_id}" onsubmit="return validateForm()">
            <input type="hidden" name="member_id" value="${mvo.member_id}">
            <div class="panel-heading">회원수정</div>
            <div class="panel-body">
               <!-- 이미지 업로드 -->
                 <div id="imagePreviewContainer"
    style="display: flex; align-items: center; justify-content: center; border-radius: 30px; width: 450px; height: 400px; object-fit: container; overflow: hidden; border: 1px solid black; margin-top: 6px; margin-bottom: 6px;">
</div>
<div>
    <input type="file" name="profileimg" multiple style="margin-bottom: 6px;" onchange="previewImages(this)" />
</div>
               <!-- 이름, 아이디 -->
               <div class="form-group">
                  <label for="name">이름</label>
                  <input id="name" name="name" value="${mvo.name}" class="form-control" type="text" maxlength="20" readonly>
               </div>
               <div class="form-group">
                  <label for="member_id">아이디</label>
                  <div class="input-group">
                     <input id="member_id" name="member_id" value="${mvo.member_id}" class="form-control" maxlength="20" readonly>
                  </div>
               </div>
               <!-- 닉네임 -->
               <div class="form-group">
                  <label for="nickname">닉네임</label>
                  <input id="nickname" name="nickname" class="form-control" maxlength="20" value="${mvo.nickname }">
               </div>
     <c:if test="${!isSocial}">
    <!-- 비밀번호 입력 -->
    <div class="form-group">
        <label for="password">비밀번호</label>
        <div class="input-group">
            <input id="password" name="password" onkeyup="passwordCheck()"
                   class="form-control" type="password" maxlength="20"
                   placeholder="비밀번호를 입력하세요." />
            <span class="input-group-addon">
                <i id="togglePassword" class="glyphicon glyphicon-eye-close"
                   onclick="togglePassword()"></i>
            </span>
        </div>
    </div>
    <!-- 비밀번호 확인 -->
    <div class="form-group">
        <label for="password2">비밀번호 확인</label>
        <div class="input-group">
            <input id="password2" name="password2" onkeyup="passwordCheck()"
                   class="form-control" type="password" maxlength="20"
                   placeholder="비밀번호를 다시 입력하세요." />
            <span class="input-group-addon">
                <i id="togglePassword2" class="glyphicon glyphicon-eye-close"
                   onclick="togglePassword2()"></i>
            </span>
        </div>
        <p id="passMessage" style="color: red;"></p> <!-- 비밀번호 일치 여부 메시지 -->
    </div>
</c:if>

               <!-- 전화번호 -->
               <div class="form-group">
                  <label for="phone">전화번호</label>
                  <input id="phone" name="phone" value="${mvo.phone}" type="text" class="form-control" oninput="autoHyphen2(this)" maxlength="13" placeholder="전화번호를 입력하세요">
               </div>
               <!-- 이메일 -->
               <div class="form-group">
                  <label for="email">이메일</label>
                  <input id="email" type="text" name="email" value="${mvo.email}" title="이메일 주소를 입력해주세요." required class="form-control" readonly>
               </div>
               <!-- 주소 -->
               <div class="form-group">
                  <label for="sample6_postcode">우편번호</label>
                  <div class="input-group">
                     <input type="text" id="zipcode" class="form-control" name="zipcode" value="${mvo.zipcode}" placeholder="우편번호">
                     <span class="input-group-btn">
                        <button class="btn btn-primary" type="button" onclick="sample6_execDaumPostcode()">주소찾기</button>
                     </span>
                  </div>
               </div>
               <!-- 주소 입력 -->
               <div class="form-group">
                  <label for="sample6_address">주소</label>
                  <input type="text" id="addr" name="addr" value="${mvo.addr}" class="form-control" placeholder="주소">
               </div>
               <div class="form-group">
                  <label for="sample6_detailAddress">상세주소</label>
                  <input type="text" id="detailaddr" name="detailaddr" value="${mvo.detailaddr}" class="form-control" placeholder="상세주소">
               </div>
               <div class="form-group">
                  <label for="sample6_extraAddress"></label>
                  <input type="text" id="sample6_extraAddress" class="form-control" placeholder="참고항목">
               </div>
               <!-- 수정하기 버튼 -->
               <div class="form-group">
                  <div style="width: auto; margin: 0 auto;">
                     <input type="submit" value="수정하기" class="btn btn-primary btn-block">
                  </div>
               </div>
            </div>
      </div>
      </form>
   </div>
   <!--  다이얼로그창(모달) -->
   <!-- Modal -->
   <div id="myModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
         <!-- Modal content-->
         <div id="checkType" class="modal-content panel-info">
            <div class="modal-header panel-heading">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
               <p id="checkMessage"></p>
               ㄴ
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
</body>
</html>