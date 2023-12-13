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

<!-- Slick Slider CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<!-- ... (your existing imports) ... -->
<body>
	<c:import url="include/header.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<div class="slider-container container">
		<div class="slider-show">
			<div>
				<img class="main-slickImg" alt="" src="${contextPath }/resources/image/slideImage1.jpg">
			</div>
			<div>
				<img class="main-slickImg" alt="" src="${contextPath }/resources/image/slideImage2.jpg">
			</div>
			<div>
				<img class="main-slickImg" alt="" src="${contextPath }/resources/image/slideImage3.jpg">
			</div>
		</div>
		<div class="slick-status"><h3>1</h3><h4>/3</h4></div>
		<button class="slick-prev prevBtn">Previous</button>
		<button class="slick-next nextBtn">Next</button>
	</div>



	<div class="container">test</div>

	<script>
		$(document).ready(function() {
			var slick = $('.slider-show');
			slick.slick({
				infinite : true,
				speed : 500,
				arrows : true,
				autoplay : true,
				autoplaySpeed : 10000,
				pauseOnHover : true,
				prevArrow : $('.slick-prev'),
				nextArrow : $('.slick-next')
			});

			slick.on('afterChange', function(event, slick, currentSlide) {
				$('.slick-status h3').html(currentSlide+1);
			});
		});
	</script>
</body>
</html>
