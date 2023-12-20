<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/signIn.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
</head>
<body>
	<script>
		$(document).ready(function() {
			$(".login-main").click(function() {
				location.href = "${contextPath}/";
			});
			
			$(".login-inputPass").keydown(function(e){
				if(e.keyCode == 13){
					location.href = "${contextPath}/account/check?member_id=" + $(".login-inputUser").val() + "&password=" + $(".login-inputPass").val();
				}
			});

			$(".login-btnLogin").click(function() {
				location.href = "${contextPath}/account/check?member_id=" + $(".login-inputUser").val() + "&password=" + $(".login-inputPass").val();
			});

			$(".login-findId").click(function() {
				location.href = "${contextPath}/account/findId";
			});

			$(".login-findPw").click(function() {
				location.href = "${contextPath}/account/findPw";
			});

			$(".login-signUp").click(function() {
				location.href = "${contextPath}/account/signUp";
			});
		});
	</script>
	<script>
		// 서버에서 전달된 메시지가 있는지 확인하여 모달을 표시합니다.
	<%if (request.getAttribute("msgType") != null && request.getAttribute("msg") != null) {%>
		$(document).ready(function() {
			$('#messageModal').modal('show');
		});
	<%}%>
		
	</script>
	<div class="login-box">
		<div class="login-logo">
			<button class="login-main">
				<img alt="" src="${contextPath }/resources/image/loginLogo.png" />
			</button>
			<br>
		</div>
		<div class="login-userBox">
			<label for="member_id">ID</label>
			<input id="member_id" name="member_id" class="login-inputUser form form-control" type="text" placeholder="아이디">
		</div>
		<div class="login-passBox">
			<label for="password">PW</label>
			<input id="password" name="password" class="login-inputPass form form-control" type="password" placeholder="비밀번호">
		</div>
		<button class="login-btnLogin btn" type="submit">로그인</button>
		<div class="login-bar">
			<img alt="" src="${contextPath }/resources/image/loginBar.png" />
		</div>
		<div class="login-social">
			<a href="${contextPath }/account/kakaoLogin">
				<img height="75" src="${contextPath }/resources/image/loginKakao.svg" />
			</a>
			<a href="${contextPath }/account/googleLogin">
				<img height="75" src="${contextPath }/resources/image/loginGoogle.svg" />
			</a>
			<a href="${contextPath }/account/naverLogin">
				<img height="75" src="${contextPath }/resources/image/loginNaver.svg" />
			</a>
		</div>
		<div class="login-help">
			<button class="login-findId">아이디 찾기</button>
			<h5>|</h5>
			<button class="login-findPw">비밀번호 찾기</button>
			<h5>|</h5>
			<button class="login-signUp">회원가입</button>
		</div>
	</div>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="messageModalLabel">${msgType}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>${msg}</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>