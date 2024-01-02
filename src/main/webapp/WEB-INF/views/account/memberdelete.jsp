<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!DOCTYPE html>
<html lang="en">
<head>
<script>
function checkPassword() {
    var password = document.getElementById('password').value;
    var storedPassword = "${mvo.password}";

    if (password !== storedPassword) {
        alert('비밀번호가 틀렸습니다.');
        return false;
    } else {
        $('#confirmModal').modal('show');
        return false;
    }
}

function redirectToMain() {
    window.location.replace("${contextPath}/");
}

function confirmWithdrawal() {
    // 여기서 서버로 회원 탈퇴 요청을 보낼 수 있습니다.
    // 이 예제에서는 서버 요청 대신에 알림창으로 처리합니다.
    alert('회원 탈퇴가 완료되었습니다.');
    redirectToMain();
}
    </script>
</head>
<body>
   <jsp:include page="../include/header.jsp" />
   <title>회원 탈퇴</title>
   <form id="deleteForm" method="post" action="${contextPath}/account/memberdelete" onsubmit="return checkPassword()">

      <div class="container">
         <hr>
         <div class="panel panel-default">
            <div class="panel-heading">회원탈퇴</div>
            <div class="panel-body">
               <div class="form-group">
                  <p>
                     Buy Buy 웹사이트에서 회원님의 계정이 삭제됩니다.<br> 탈퇴시 개인정보 및 이용정보가 삭제되어 복구할
                     수 없습니다.<br> 계정 비밀번호를 입력한 후 하단의 유의사항 동의에 체크하시길 바랍니다.
                  </p>
                  <label for="password">계정 비밀번호</label> <input type="password"
                     class="form-control" id="password" name="password"
                     placeholder="비밀번호를 입력하세요">
               </div>
               <div class="checkbox">
                  <label> <input type="checkbox" required> 위의 유의사항을
                     모두 확인하였으며 동의합니다.
                  </label>
               </div>
               <button type="submit" class="btn btn-danger">회원 탈퇴</button>
            </div>
         </div>
      </div>
 <div id="confirmModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">정말로 탈퇴하시겠습니까?</h4>
                </div>
                <div class="modal-body">
                    <p>계정을 삭제하시면 해당 정보는 복구할 수 없습니다.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
    <button type="button" class="btn btn-danger" onclick="document.getElementById('deleteForm').submit()">탈퇴</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>