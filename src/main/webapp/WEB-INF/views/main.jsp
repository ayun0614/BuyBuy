<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/main.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>

<script type="text/javascript">
	$(document).ready(function(){
		const slideContainer = $(".slide-container");
		alert(slideContainer);
	});
</script>
</head>
<body>
	<c:import url="include/header.jsp" />
	<div class="slide-container container">
		<div class="slide-box">
			<ul class="slide-slider">
				<li><img class="slide-image" src="${contextPath }/resources/image/slideImage1.jpg" alt="" /></li>
				<li><img class="slide-image" src="${contextPath }/resources/image/slideImage2.jpg" alt="" /></li>
				<li><img class="slide-image" src="${contextPath }/resources/image/slideImage3.jpg" alt="" /></li>
			</ul>
		</div>
	</div>
</body>
</html>