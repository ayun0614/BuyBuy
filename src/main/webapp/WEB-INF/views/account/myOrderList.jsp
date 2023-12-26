<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/myOrderList.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
<style>

</style>
<script>
	$(document).ready(function() {
		waitList();
	});

	function orderDelBtn(order_num) {
		$.ajax({
			url : "${contextPath}/account/statusUpdate",
			type : "put",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order_num),
			dataType : 'JSON',
			success : function(data) {
				alert('취소 신청이 완료되었습니다.');
				location.reload();
			},
			error : function() {
				alert("error");
			}
		});

	}

	function orderDeliBtn() {
		location.href = 'http://st.sweettracker.co.kr/#/';
	}

	function waitList() {
		$.ajax({
			url : "${contextPath}/account/all",
			type : "get",
			dataType : "json",
			success : createView,
			error : function() {
				alert("error");
			}
		});
	}

	function createView(data) {
		var list = "<div>";

		$.each(data, function(index, obj) {
			list += "<div class = 'orderStatusBox'>";
			list += "<div class = 'orderStatusText' style = 'font-size:20px;' id = 'sta"+obj.order_num+"'>" + obj.status + "</div>";
			list += "<div class = 'orderDateText' style = 'font-size:20px;'>신청일자 " + obj.order_date + "</div>";
			list += "<div class = 'orderInfoText' style = 'font-size:20px;'><a href = '${contextPath}/account/myOrderInfo?order_num=" + obj.order_num + "' style = 'text-decoration:none; color: black;'>주문상세<img src = '${contextPath}/resources/image/myPageGo.png' class = 'goBtn'></a></div>";
			list += "</div>";
			list += "<div class = 'productInfoBox'>";
			list += "<div class = 'productInfoImgDiv'><img src='' class = 'productInfoImg'/></div>";
			list += "<div>";
			list += "<table>";
			list += "<tr>";
			list += "<td style = 'font-size:24px; font-weight: 700;'>" + obj.product_name + "</td>";
			list += "</tr>";
			list += "<tr>";
			list += "<td style = 'font-size:15px;'>구매 수 " + obj.order_pcs + "개</td>";
			list += "</tr>";
			list += "<tr><td></td></tr>";
			list += "<tr><td></td></tr>";
			list += "<tr>";
			if (obj.status == "주문 완료") {
				list += "<td colspan = '2' align='right'><button type='button' class='btn btn-danger' onclick = 'orderDelBtn()'>주문 취소</button></td>";
			} else if (obj.status == "배송중") {
				list += "<td colspan = '2' align='right'><button type='button' class='btn btn-default' onclick = 'orderDeliBtn()'>배송 조회</button></td>";
			} else if (obj.status == "배송 완료") {
				list += "<td colspan = '2' align='right'></td>";
			} else if (obj.status == "취소 완료") {
				list += "<td colspan = '2' align='right'></td>";
			}
			list += "</tr>";
			list += "<tr>";
			list += "<td style = 'font-size:20px;' colspan = '2' align='right'>개당 <b>" + obj.discount_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</b></td>";
			list += "</tr>";
			list += "</table>";
			list += "</div>";
			list += "</div>";
			list += "<hr class = 'hrSec'>";
		});
		list += "</div>";

		$("#view").html(list);
	}
</script>
</head>
<body>
	<c:import url="../include/header.jsp" />
	<div class="bodyDiv">
		<div class="myPageSubDiv">
			<a href="${contextPath }/account/myPage"><img src="${contextPath }/resources/image/myPageBack.png" class="backBtn"></a>
			<div class="myPageSubText">주문 / 배송 조회</div>
		</div>
		<hr>
		<div id="view"></div>
	</div>
</body>
</html>