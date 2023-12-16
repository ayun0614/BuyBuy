<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<title>Bootstrap Example</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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

	<div class="container" style="max-width: 900px; height: 100px;">
		<jsp:include page="../include/header.jsp" />
		<br>

		<div class="row middle">
			<div class="container" style="max-width: 900px; height: 700px;">

				<div class="col-12 mx-auto">

					<c:forEach items="${ProductList}" var="product">
						<a
							href="${contextPath}/ProductDetail?product_idx=${product.product_idx}">
							<div class="col-sm-6 col-md-4" style="width: 216px;">
								<div class="card-ui">
									<div class="thumbnail">
										<img src="${contextPath}/resources/upload/${product.thumbnail_img}"
											alt="thumbnail_img">
										<div class="caption">
											<div style="text-decoration: line-through;">
												<td>${product.original_price}</td>
											</div>
											<td>${product.discount_price}</td>
											<td>${product.discount_rate}%</td>
											<tr>
												<td>${product.product_name}</td>
											</tr>
											<input type="hidden" id="endDate" value="${product.end_date}">
											<div id="countdown_${product.product_idx}"></div>
											<p>
												<a href="#" class="btn btn-primary" role="button">Button</a>
												<a href="#" class="btn btn-default" role="button">Button</a>
											</p>
										</div>
									</div>
								</div>
							</div>
						</a>
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

            // If the countdown is over, display a message
            if (distance < 0) {
                clearInterval(x_${product.product_idx});
                document.getElementById("countdown_${product.product_idx}").innerHTML =
                    "공구종료";
            }
        }, 1000);
    </script>
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