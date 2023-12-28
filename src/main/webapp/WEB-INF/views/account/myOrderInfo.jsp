<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<<<<<<< Updated upstream
<c:set var='contextPath' value="${pageContext.request.contextPath }/" />
=======
<c:set var='root' value="${pageContext.request.contextPath }/" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
>>>>>>> Stashed changes
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/myOrderInfo.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="bodyDiv">
		<div class="myPageSubDiv">
			<a href="${contextPath }/account/myOrderList">
				<img src="${contextPath }/resources/image/myPageBack.png" class="backBtn">
			</a>
			<div class="myPageSubText">주문 상세</div>
		</div>
		<hr>
		<div class="productInfoSubText">주문 상품 정보</div>
		<div class="productInfoBox">
			<div class="productInfoImg">
				<img src="" class="myInfoImg"/>
			</div>
			<div class="productInfoBox2">
				<div style="font-weight: 900; font-size: 18px;">${mo.product_name}</div>
				<br>
				<div style="font-size: 12px;">수량 ${mo.order_pcs}개</div>
				<br> <br>
				<div style="font-weight: 900; font-size: 18px;">
					<fmt:formatNumber value="${mo.discount_price }" pattern="#,##0" />
					원
				</div>
			</div>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">주문자 정보</div>
		<div class="userInfoBox">
			<table class="userInfoTbl">
				<tr class="userInfoTr">
					<td style="width: 20px;" class="userInfoTd">주문자 이름</td>
					<td style="width: 110px;" class="userInfoTd"><span id="userInfoNameSpan">${mo.name}</span></td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 20px;" class="userInfoTd">전화번호</td>
					<td style="width: 110px;" class="userInfoTd"><span id="userInfoTelSpan">${mo.phone}</span></td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">배송 정보</div>
		<div class="userInfoBox">
			<table class="userInfoTbl" style="width: 800px;">
				<tr class="userInfoTr">
					<td style="width: 20px;">받는 사람</td>
					<td style="width: 110px;" class="userInfoTd">${mo.deli_name}</td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 20px;">전화번호</td>
					<td style="width: 110px;" class="userInfoTd">${mo.deli_phone}</td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 20px;">주소</td>
					<td style="width: 110px;" class="userInfoTd">${mo.deli_zipcode}&nbsp${mo.deli_addr}&nbsp${mo.deli_detailaddr}</td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 20px;">배송 메모</td>
					<td style="width: 110px;" class="userInfoTd">${mo.deli_memo}</td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">결제 금액</div>
		<div class="userInfoBox">
			<table class="userInfoTbl" style="width: 770px;">
				<tr class="userInfoTr">
					<td>상품 가격</td>
					<td style="text-align: right"><fmt:formatNumber value="${mo.original_price}" pattern="#,##0" />원</td>
				</tr>
				<tr class="userInfoTr">
					<td>할인</td>
					<td style="text-align: right">- ${mo.original_price-mo.discount_price}원</td>
				</tr>
				<tr class="userInfoTr">
					<td>배송비</td>
					<td style="text-align: right">+ 2,500원</td>
				</tr>
				<tr class="userInfoTr">
					<td class="lastPayTextTd">총 결제 금액</td>
					<td class="lastPayTd"><fmt:formatNumber value="${mo.total_price}" pattern="#,##0" />원</td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">결제 수단</div>
		<div style="margin-top: 20px; margin-left: 100px;">
			<label style="font-size: 18px;">${mo.pay_type}</label>
		</div>
		<br> <br> <br> <br> <br>
	</div>
</body>
</html>