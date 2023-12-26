<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<title>Bootstrap Example</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.top, .middle-left, .middle-right, .middle-right-1, .middle-right-2,
	.middle-right-3, .bottom {
	text-align: center;
	padding: 20px;
	border: 1px solid #9F9F9F;
}

.nav-tabs {
	display: flex;
	justify-content: center;
}

.nav-tabs li {
	float: none;
	display: inline-block;
}

.tab-content {
	text-align: center;
}

.middle-left {
	height: 389px;
}

.middle-right {
	height: 389px;
}

.middle-col {
	width: 25%;
	padding: 15px;
}

.card-ui {
	display: none;
}
</style>
</head>
<body>
	<!-- header.jsp 파일을 포함 -->
	<jsp:include page="../include/header.jsp" />
	<div class="container" style="max-width: 1000px; height: 100px;">
		<br>
		<!-- 로그인한 사용자인 경우에만 "게시글 등록" 링크 표시 -->
		<c:if test="${!empty mvo}">
			<a href="${contextPath}/product/ProductListInsert">게시글 등록</a>
		</c:if>
		<hr>
		<!-- 사용자의 member_id 값을 hidden 필드로 저장 -->
		<input type="hidden" name="member_id" value="${mvo.member_id}" />
		<br>
		<div class="row middle">
			<div class="container" style="max-width: 900px; height: 700px;">
				<div class="col-12 mx-auto">
					<!-- ProductList에 있는 각각의 상품에 대한 정보를 출력 -->
					<c:forEach items="${ProductList}" var="product">
						<a href="${contextPath}/product/ProductDetail?product_idx=${product.product_idx}">
							<div class="col-sm-6 col-md-4" style="width: 216px;">
								<div class="card-ui">
									<div class="thumbnail" style="height: 300px;">
										<img src="${product.thumbnail_img}" alt="thumbnail_img" style="height: 150px;">
										<div class="caption">
											<td>${product.product_name}</td> <br>
											<span style="text-decoration: line-through;">
												<td>${product.original_price}원</td>
											</span>
											<br>
											<span style="color: red; font-weight: bold;">
												<td>${product.discount_price}원</td>
											</span>
											<span style="font-size: 20px;">
												<td>${product.discount_rate}</td>
											</span>
											<!-- DB에 저장된 content_state가 "판매중"이 아닌 경우 -->
											<c:if test="${product.content_state ne '판매중'}">
												<!-- DB에 저장된 content_state에 따라 상태를 표시 -->
												<c:choose>
													<c:when test="${product.content_state eq '마감'}">
														<div style="font-weight: bold;">마감</div>
													</c:when>
													<c:when test="${product.content_state eq '배송중'}">
														<div style="font-weight: bold;">배송중</div>
													</c:when>
													<c:when test="${product.content_state eq '배송완료'}">
														<div style="font-weight: bold;">배송완료</div>
													</c:when>
												</c:choose>
											</c:if>
											<!-- DB에 저장된 content_state가 "판매중"인 경우에는 시간 흐름 표시 -->
											<c:if test="${product.content_state eq '판매중'}">
												<input type="hidden" id="endDate" value="${product.end_date}">
												<div id="countdown_${product.product_idx}" style="font-weight: bold;"></div>
												<script>
											        // Set the date we're counting down to
											        var countDownDate_${product.product_idx} = new Date("${product.end_date}").getTime();
											
											        // Update the countdown every 1 second
											        var x_${product.product_idx} = setInterval(function () {
											            // Get the current date and time
											            var now = new Date().getTime();
											
											            // Calculate the remaining time
											            var distance = countDownDate_${product.product_idx} - now;
											
											            // Calculate days, hours, minutes, and seconds
											            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
											            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
											            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
											            var seconds = Math.floor((distance % (1000 * 60)) / 1000);
											
											            // Display the countdown
											            document.getElementById("countdown_${product.product_idx}").innerHTML =
											                days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초 ";
											
											            // If the countdown is over, display a message and update content_state
											            if (distance < 0) {
											                clearInterval(x_${product.product_idx});
											                document.getElementById("countdown_${product.product_idx}").innerHTML =
											                    "공구종료";
											
											       
											            }
											        }, 1000);
											    </script>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
		<button class="load-more">Load More</button>
	</div>
	<script>
        $('.card-ui').slice(0, 8).show(); // 처음 페이지에 보여지는 사진 개수
        $('.load-more').click(function () {
            $('.card-ui:hidden').slice(0, 4).fadeIn();
            if ($('.card-ui:hidden').length == 0) {
                $(this).hide();
            }
        })
    </script>
</body>
</html>