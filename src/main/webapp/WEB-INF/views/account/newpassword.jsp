<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Password Reset Form</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* Styling for the form wrapper */
     #passwordResetForm {
    margin-top: 175px;
    margin-right: auto;
    margin-left: auto;
    padding: 40px; /* 여백을 크게 조정 */
    width: 90%; /* 전체 크기를 90%로 조정 */
    max-width: 600px; /* 최대 너비 설정 */
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
        }

        .form-group {
            margin-bottom: 20px;
        }
        h3 {
    text-align: center;
    margin-bottom: 30px; /* 제목과의 간격을 늘림 */
    color: #333;
    font-size: 28px; /* 제목 크기 키우기 */
}
#modifyBtn{
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    display: block;
    width: calc(100%);
    margin-top: 10px;
    }
    label {
    font-weight: bold;
    font-size: 18px; /* 라벨 폰트 크기 키우기 */
}
    </style>
</head>
<body>
    <jsp:include page="../include/header.jsp" />
    <div class="container">
        <input type="hidden" id="member_id" value="${member_id}" />
        
        <!-- Form with Bootstrap classes -->
        <form id="passwordResetForm">
         <h3>비밀번호 재설정</h3>
            <div class="form-group">
                <label for="newPassword">새로운 비밀번호:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">새로운 비밀번호 확인:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-primary" id="modifyBtn">비밀번호 변경</button>
            </div>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            $(document).on("click", "#modifyBtn", function() {
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmPassword').val();

                if (newPassword !== confirmPassword) {
                    alert('새로운 비밀번호와 확인용 비밀번호가 일치하지 않습니다.');
                    return;
                }

                let memberInfo = {
                    "member_id": $('#member_id').val(),
                    "password": newPassword
                }

                $.ajax({
                    type: 'POST',
                    url: '${contextPath}/account/passwordmodify',
                    data: memberInfo,
                    success: function(response) {
                        alert('비밀번호가 성공적으로 변경되었습니다.');
                        window.location.href = "${contextPath}/account/signIn";
                    },
                    error: function() {
                        alert('비밀번호 변경에 실패했습니다.');
                    }
                });
            });
        });
    </script>
</body>
</html>
