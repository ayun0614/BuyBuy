<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	background-color:#ffffff;
	width: 1000px;
	margin: auto;
}

.myPageSubDiv {
	margin-top:35px; 
	display:flex;
}

.backBtn {
	margin-left: 70px;
	width: 24.42px;
	height: 41.39px;
}

.myPageSubText {
	margin-left: 305px;
	font-weight: 900;
	font-size:32px;
	text-align:center;
}
 
hr{
	height:1px;
	background-color:#AFAFAF;
	width:94%;
	margin-top:35px;
}

.productInfoSubText {
	margin-left: 100px;
	margin-top:33px; 
	font-weight: 900;
	font-size:25px;
}

.productInfoBox {
	display:flex;
}

.productInfoImg{ 
	width:222px; 
	height:222px;
	margin-top:33px; 
	margin-left: 100px;
	margin-bottom:33px; 
	background-color:#537FE7;
}


.hrSec {
	height:1px;
	background-color:#AFAFAF;
	width:95%; 
	margin-top:50px;
}

.panel-heading {
	border:none;
	outline: none;
    box-shadow: none;
}

.productInfoTbl{
	margin-top:55px; 
	margin-left: 30px;
	width: 530px;
}
.productInfoTr {
	height: 30px;
}

.panelProductInfoTh, .panelProductInfoTd{
	text-align:center;
}


</style>

<script>
$(document).ready(function(){
	waitList();
});

function waitList(){
	$.ajax({ 
		url:"mypage/postingAll",
		type:"get",
		dataType:"json",
		success:createView,
		error:function(){
			alert("error");
		}
	});
}

function createView(data){ 
	var list = "<div>";
	$.each(data, function(index,obj){
		list += "<div class='panel-group' id='accordion' style = 'border-color:#ffffff;'>";
		list += "<div>";
		list += "<div class='panel-heading' style = 'background-color:#ffffff;'>";
		list += "<h4 class='panel-title'> ";
			list += "<a data-toggle='collapse' data-parent='#accordion' href='#collapse"+obj.product_idx+"' style = 'text-decoration:none;'>";
				list += "<div class = 'productInfoBox'>";
					list += "<div class = 'productInfoImg'>"+obj.thumbnail_img+"</div>";
				list += "<div></a>";
			list += "<table class = 'productInfoTbl'>"; 
				list += "<tr class = 'productInfoTr'>";
					list += "<td class = 'productInfoTd' style = 'font-size:24px; font-weight: 700;'>상품명</td>";
					list += "<td class = 'productInfoTd' align = 'right' style = 'font-size:16px;'><a href='' style = 'text-decoration:none; color: black;'>상품 게시글 상세 &nbsp&nbsp <img src = 'resources/image/Go.png' class = 'goBtn'></a></td>";
				list += "</tr>";
				list += "<tr class = 'productInfoTr'>"; 
					list += "<td style = 'font-size:17px;' class = 'productInfoTd'>마감일 "+ obj.end_date +"</td>";
				list += "</tr>";
				list += "<tr class = 'productInfoTr'>";
					list += "<td></td>";
				list += "</tr>";
				list += "<tr class = 'productInfoTr'><td></td></tr>";
				list += "<tr class = 'productInfoTr'>";
					list += "<td class = 'productInfoTd' colspan = '2' align='right'><del>"+ obj.original_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') +"<del>원</td>";
				list += "</tr>";
				list += "<tr class = 'productInfoTr'>";
					list += "<td class = 'productInfoTd' colspan = '2' align='right' style = 'font-size:24px; font-weight: 700; color:red;'><b>"+ obj.discount_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') +"원</b></td>";
				list += "</tr>";
			list += "</table>";
		list += "</h4>";
		list += "</div>";
		
		list += "<div id='collapse"+obj.product_idx+"' class='panel-collapse collapse'>";
			list += "<div class='panel-body'>";
				list += "<div class='container'>";
					list += "<table class='table' style = 'width:940px'>";
						list += "<thead>";
							list += "<tr>";
								list += "<th class = 'panelProductInfoTh'>상품 ID</th>";
								list += "<th class = 'panelProductInfoTh' style = 'width: 400px;'>게시글 제목</th>";
								list += "<th class = 'panelProductInfoTh'>판매자 ID</th>";
								list += "<th class = 'panelProductInfoTh'>구매 수량</th>";
								list += "<th class = 'panelProductInfoTh'>조회수</th>";
							list += "</tr>";
						list += "</thead>";
						list += "<tbody>";
							list += "<tr>";
							list += "<td class = 'panelProductInfoTd'>"+ obj.product_idx +"</td>";
							list += "<td class = 'panelProductInfoTd' style = 'width: 400px;'>"+ obj.product_name +"</td>";
							list += "<td class = 'panelProductInfoTd'>"+ obj.member_id +"</td>";
							list += "<td class = 'panelProductInfoTd'>"+ obj.cnt +"</td>";
							list += "<td class = 'panelProductInfoTd'>"+ obj.view_count +"</td>";
							list += "</tr>";
						list += "</tbody>";
					list += "</table>";
				list += "</div>";
			list += "</div>";
		list += "</div>";

		list += "<hr>";
		
	});
	list += "</div>";
	
	$("#view").html(list);
}
</script>
</head>
<body>
<jsp:include page="../include/header.jsp"/> 
<div class = "bodyDiv">
  	<div class = "myPageSubDiv"><a href = "myPageMain"><img src = "resources/image/Back.png" class = "backBtn"></a>
		<div class = "myPageSubText">등록한 게시물</div>
	</div>
	<hr>
	
	<div id = "view"></div>

</div>
</body>
</html>