<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <title>회원 탈퇴</title>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
 <jsp:include page="../include/header.jsp" />
    <form method="post" action="${contextPath}/account/memberdelete" onsubmit="withdrawComplete();">
        <div class="container">
            <hr>
            <div class="panel panel-default">
                <div class="panel-heading"> 회원탈퇴</div>
                <div class="panel-body">
                    <div class="form-group">
                        <p>Buy Buy 웹사이트에서 회원님의 계정이 삭제됩니다.<br>
                            탈퇴시 개인정보 및 이용정보가 삭제되어 복구할 수 없습니다.<br>
                            계정 비밀번호를 입력한 후 하단의 유의사항 동의에 체크하시길 바랍니다.
                        </p>
                        <label for="password">계정 비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요">
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" required> 위의 유의사항을 모두 확인하였으며 동의합니다.
                        </label>
                    </div>
                    <button type="submit" class="btn btn-danger">회원 탈퇴</button>
                </div>
            </div>
        </div>
           <div class="modal fade" id="withdrawSuccessModal" tabindex="-1" role="dialog" aria-labelledby="withdrawSuccessModalLabel">
    <!-- Modal structure for withdrawal success -->
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">회원 탈퇴 성공</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p>회원 탈퇴가 성공적으로 이루어졌습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- Withdrawal Failure Modal -->
<div class="modal fade" id="withdrawFailModal" tabindex="-1" role="dialog" aria-labelledby="withdrawFailModalLabel">
    <!-- Modal structure for withdrawal failure -->
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">회원 탈퇴 실패</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p>비밀번호가 일치하지 않습니다. 다시 확인해주세요.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
    </form>
    <script>
    function withdrawComplete() {
        var password = document.getElementById('password').value; // Get the entered password

        // 입력한 비밀번호를 서버에 안전하게 전송하여 비교
        fetch('${contextPath}/account/memberdelete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ password: password })
        })
        .then(response => response.json())
        .then(data => {
            if (data.isValid) {
                // Show withdrawal success modal
                $('#withdrawSuccessModal').modal('show');
            } else {
                // Show withdrawal failure modal
                $('#withdrawFailModal').modal('show');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });

        return false; // Prevent form submission
    }

    </script>

</body>
</html>
