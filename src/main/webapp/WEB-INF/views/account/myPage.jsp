<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/myPage.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
<style>

</style>
<script>
	$(document).ready(function() {

		$('#dealerChangeReq').click(function() {

			var id = '${mo.member_id }';

			if ('${mo.account_type}' === 'dealer') {
				alert("판매자 계정입니다.");
			} else {

				$.ajax({
					url : "mypage/dealerRequest",
					type : "put",
					data : id,
					success : function(data) {
						alert(id);
						console.log(id);
					},
					error : function(data) {
						alert("이미 신청한 계정입니다.");
						console.log(id);
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<c:import url="../include/header.jsp" />
	<div class="bodyDiv">
		<div class="myPageSubText">마이페이지</div>
		<hr>
		<div class="myInfoBox">
			<div class="myInfoImgDiv">
				<img src="" class="myInfoImg" />
			</div>
			<table class="myInfotbl">
				<tr>
					<td style="font-size: 20px;">${mo.name }</td>
					<td style="font-size: 20px;">&nbsp&nbsp | &nbsp&nbsp ${mo.nickname }</td>
				</tr>
				<tr>
					<td colspan="2" id="member_idReq"><br>${mo.member_id }</td>
				</tr>
			</table>
			<div class="myInfoEditPage">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageSettings.png">
					<br>회원 정보 수정
				</a>
			</div>
		</div>
		<div class="orderStatus">
			<table class="orderStatustbl">
				<tr>
					<td class="orderStatustd">주문완료</td>
					<td class="orderStatustd">배송중</td>
					<td class="orderStatustd">배송완료</td>
				</tr>
				<tr>
					<td style="font-size: 20px;">${mvo.count_orderend}</td>
					<td style="font-size: 20px;">${mvo.count_ing}</td>
					<td style="font-size: 20px;">${mvo.count_end}</td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="myPageMoveBox">
			<c:if test="${mo.account_type eq 'user' }">
				<div class="myPageMoveDiv" style="font-size: 20px;">
					<a href="${contextPath }/account/myOrderList" style="text-decoration: none; color: black;">
						<img src="${contextPath }/resources/image/myPageCart.png">
						<br>구매한 상품
					</a>
				</div>
			</c:if>
			<c:if test="${mo.account_type eq 'dealer' }">
				<div class="myPageMoveDiv" style="font-size: 20px;">
					<a href="${contextPath }/account/myProducts" style="text-decoration: none; color: black;">
						<img src="${contextPath }/resources/image/myPageList.png">
						<br>등록한 상품
					</a>
				</div>
			</c:if>
			<div class="vl"></div>
			<div class="myPageMoveDiv" id="dealerChangeReq" style="font-size: 20px;">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageRequest.png">
					<br>판매자 계정 신청
				</a>
			</div>
			<div class="vl"></div>
			<div class="myPageMoveDiv" style="font-size: 20px;">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageKey.png">
					<br>계정 탈퇴
				</a>
			</div>
		</div>
	</div>
</body>
</html>