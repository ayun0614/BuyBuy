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
		<div class="slick-status">
			<h3>1</h3>
			<h4>/ 3</h4>
		</div>
		<button class="slick-prevBtn"><</button>
		<button class="slick-nextBtn">></button>
	</div>

	<div class="product-container container">
		<h3 class="product-header">인기 공동구매 상품</h3>
		<div class="product-flex">
			<div class="product-content" onclick="location.href='${contextPath}/product/content'">
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-example1.jpg">
				<h1>조명,인테리어 | 디퓨저</h1>
				<h2>[코코도르]</h2>
				<h2>크리스마스 디퓨저 200ml x2</h2>
				<h3>10,900원</h3>
				<h4>27,900원</h4>
				<h5>22D 07H</h5>
			</div>
			<div class="product-content" onclick="location.href='${contextPath}/product/content'">
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-example2.jpg">
				<h1>신선식품 | 뿌리채소</h1>
				<h2>[선한에프엔비] </h2>
				<h2>해남 황토밭 꿀고구마 2kg</h2>
				<h3>8,500원</h3>
				<h4>15,900원</h4>
				<h5>3D 12H</h5>
			</div>
			<div>
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
			<div>
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
		</div>
	</div>
	
	<div class="product-container container">
		<h3 class="product-header">신규 등록 상품</h3>
		<div class="product-flex">
			<div class="product-content" onclick="location.href='${contextPath}/product/content'">
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
			<div class="product-content" onclick="location.href='${contextPath}/product/content'">
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
			<div>
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
			<div>
				<img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg">
				<h1></h1>
				<h2></h2>
				<h2></h2>
				<h3></h3>
				<h4></h4>
				<h5></h5>
			</div>
		</div>
	</div>

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
				prevArrow : $('.slick-prevBtn'),
				nextArrow : $('.slick-nextBtn')
			});

			slick.on('afterChange', function(event, slick, currentSlide) {
				$('.slick-status h3').html(currentSlide + 1);
			});
		});
	</script>
</body>
</html>
