<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
<style>
html, body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #ffffff;
	height: 100%;
}

.bodyDiv {
	background-color: #ffffff;
	width: 1000px;
	margin: auto;
}

.myPageSubDiv {
	margin-top: 35px;
	display: flex;
}

.backBtn {
	margin-left: 70px;
	width: 24.42px;
	height: 41.39px;
}

.myPageSubText {
	margin-left: 340px;
	font-weight: 900;
	font-size: 32px;
	text-align: center;
}

hr {
	height: 1px;
	background-color: #AFAFAF;
	width: 90%;
	margin-top: 35px;
}

.productInfoSubText, .userInfoSubText {
	margin-left: 100px;
	margin-top: 50px;
	font-weight: 900;
	font-size: 25px;
}

.productInfoBox {
	display: flex;
}

.productInfoBox2 {
	margin-left: 20px;
	margin-top: 70px;
}

.productInfoImg {
	width: 222px;
	height: 222px;
	margin-top: 33px;
	margin-left: 100px;
	background-color: #537FE7;
}

.myInfoImg {
	width: 222px;
	height: 222px;
}

.hrSec {
	height: 1px;
	background-color: #AFAFAF;
	width: 90%;
	margin-top: 50px;
}

.buyCheckbox {
	margin-top: 60px;
	margin-left: 80px;
}

#buyBtn {
	background-color: #537FE7;
	color: #ffffff;
	width: 840px;
	height: 70px;
	margin-top: 20px;
	margin-bottom: 50px;
}

.paymentRadioGroup {
	margin-left: 120px;
}

.paymentRadio {
	margin-top: 30px;
	margin-right: 90px;
}

.paymentRadioDiv {
	display: flex;
	margin-top: 40px;
}

.form-control {
	margin-right: 90px;
	width: 330px;
}

.userInfoTbl {
	width: 800px;
	margin-left: 100px;
	margin-top: 20px;
}

.userInfoTr {
	height: 30px;
}

.userInfoTd {
	width: 105px;
}

.lastPayTextTd {
	font-size: 18px;
	font-weight: 900;
}

.lastPayTd {
	text-align: right;
	font-weight: 900;
	font-size: 18px;
	color: #537FE7;
}
</style>

<script type="text/javascript">
	
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<input type="hidden" id="member_id" name="member_id" value="${mvo.member_id }">
	<input type="hidden" id="order_num" name="order_num" value="${mo.order_num }">
	<div class="bodyDiv">
		<div class="myPageSubDiv">
			<a href="myPageOrder?member_id=${mvo.member_id }"><img src="resources/image/Back.png" class="backBtn"></a>
			<div class="myPageSubText">주문 상세</div>
		</div>
		<hr>
		<div class="productInfoSubText">주문 상품 정보</div>
		<div class="productInfoBox">
			<div class="productInfoImg">
				<img src="" class="myInfoImg" "/>
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