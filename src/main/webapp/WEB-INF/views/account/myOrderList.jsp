<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<c:set var="contextPath" value="${pageContext.request.contextPath}" />
			<!DOCTYPE html>
			<html>

			<head>
				<link rel="preconnect" href="https://fonts.googleapis.com">
				<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
				<link
					href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap"
					rel="stylesheet">

				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
				<meta charset="UTF-8">
				<title>BuyBuy</title>
				<style>
					html,
					body {
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
						margin-left: 280px;
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

					.orderStatusBox {
						display: flex;
						margin-left: 82px;
						margin-top: 50px;
						width: 836px;
						height: 93px;
						background-color: #E9F8F9;
						border-radius: 25px 25px 25px 25px;
					}

					.orderStatusText {
						width: 300px;
						margin-left: 40px;
						margin-top: 33px;
						text-align: center;
					}

					.orderDateText {
						width: 500px;
						margin-left: 20px;
						margin-top: 33px;
						text-align: center;
					}

					.orderInfoText {
						width: 400px;
						margin-left: 270px;
						margin-top: 33px;
						text-align: center;
					}

					.goBtn {
						margin-left: 10px;
						margin-bottom: 5px;
						height: 30px;
					}

					.productInfoBox {
						display: flex;
					}

					.productInfoImgDiv {
						width: 222px;
						height: 222px;
						margin-top: 33px;
						margin-left: 100px;
						background-color: #537FE7;
					}

					.productInfoImg {
						width: 222px;
						height: 222px;
					}

					.hrSec {
						height: 1px;
						background-color: #AFAFAF;
						width: 90%;
						margin-top: 50px;
					}

					table {
						margin-top: 60px;
						margin-left: 30px;
					}

					tr {
						height: 30px;
					}

					td {
						width: 500px;
						font-size: 18px;
					}
				</style>

			</head>

			<body>
				<jsp:include page="../include/header.jsp" />
				<input type="hidden" id="member_id" name="member_id" value="${mvo.member_id }">
				<div class="bodyDiv">
					<div class="myPageSubDiv">
						<a href="myPage?member_id=${mvo.member_id}"><img src="${contextPath}/resources/image/Back.png"
								class="backBtn"></a>
						<div class="myPageSubText">주문 / 배송 조회</div>
					</div>
					<hr>
					<div id="view"></div>
				</div>
			</body>
			<script>
				$(document).ready(function () {
					waitList();
				});


				function createView(data) {
					var list = "<div>";

					$.each(data, function (index, obj) {
						list += "<input type='hidden' id='order_num' name='order_num' value='" + obj.order_num + "'>";
						list += "<div class = 'orderStatusBox'>";
						if (obj.status == "주문 취소") {
							list += "<div class = 'orderStatusText' style = 'font-size:20px; color:red; font-weight: 700;' id = 'sta" + obj.order_num + "'>" + obj.status + "</div>";
						} else {
							list += "<div class = 'orderStatusText' style = 'font-size:20px; font-weight: 700;' id = 'sta" + obj.order_num + "'>" + obj.status + "</div>";
						}
						list += "<div class = 'orderDateText' style = 'font-size:20px;'>신청일자 " + obj.order_date + "</div>";
						list += "<div class = 'orderInfoText' style = 'font-size:20px;'><a href = 'myOrderInfo?order_num=" + obj.order_num + "&member_id=${mvo.member_id }' style = 'text-decoration:none; color: black;'>주문상세<img src = '${contextPath}/resources/image/Go.png' class = 'goBtn'></a></div>";
						list += "</div>";
						list += "<div class = 'productInfoBox'>";
						list += "<div class = 'productInfoImgDiv'><img src='"+ obj.thumbnail_img +"' class = 'productInfoImg'/></div>";
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
							list += "<td colspan = '2' align='right'><button type='button' class='btn btn-danger' id = 'orderDelBtn' onclick = 'orderDelBtn(" + obj.order_num + ")'>주문 취소</button></td>";
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

				function orderDeliBtn() {
					location.href = 'http://st.sweettracker.co.kr/#/';
				}


				function waitList() {
					var member_id = $('#member_id').val();

					$.ajax({
						url: "all",
						type: "get",
						data: $('#member_id'),
						success: createView,
						error: function () {
							alert("error");
						}
					});
				}

				function orderDelBtn(order_num) {

					$.ajax({
						url: "statusUpdate?order_num=" + order_num,
						type: "put",
						success: function () {
							alert('취소 신청이 완료되었습니다.');
							location.reload();
						},
						error: function (xhr, status, error) {
							alert("error");
						}
					});

				}
			</script>
			</html>
