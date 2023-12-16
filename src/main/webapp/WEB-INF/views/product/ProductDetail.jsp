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
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

	<script>
        // Set the date we're counting down to
        var countDownDate_${product.product_IDX} = new Date("${product.end_date}").getTime();

        // Update the countdown every 1 second
        var x_${product.product_IDX} = setInterval(function () {
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
                clearInterval(x_${product.product_IDX});
                document.getElementById("countdown_${product.product_idx}").innerHTML =
                    "공구종료";
            }
        }, 1000);
    </script>
<script>
	// 정가와 판매가 입력란에 변화가 있을 때 할인율 계산 함수 호출
	function calculateDiscount() {
		// 정가와 판매가 값을 가져옴
		var regularPrice = parseFloat(document.getElementById('original_price').value);
		var salePrice = parseFloat(document.getElementById('discount_price').value);

		// 정가와 판매가가 유효한 숫자인 경우에만 계산 수행
		if (!isNaN(regularPrice) && !isNaN(salePrice)) {
			// 할인율 계산
			var discount = ((regularPrice - salePrice) / regularPrice) * 100;

			// 계산된 할인율을 할인율 입력란에 표시
			document.getElementById('discount_rate').value = discount
					.toFixed(0);
		} else {
			// 정가나 판매가가 유효한 숫자가 아닌 경우 할인율 입력란을 비움
			document.getElementById('discount_rate').value = '';
		}
	}

	function cancelImageUpload(index) {
		var previewContainer = document.getElementById('imagePreviewContainer');
		var filesInput = document.getElementsByName('memProfile')[0]; // Use getElementsByName to get the file input
		var images = previewContainer.getElementsByClassName('preview-image');
		var buttons = previewContainer.getElementsByClassName('cancel-btn');

		// 미리보기 이미지와 버튼을 삭제
		previewContainer.removeChild(images[index]);
		previewContainer.removeChild(buttons[index]);

		// 선택한 이미지를 파일 입력에서도 삭제
		filesInput.value = '';

		// 이미지 추가 버튼을 다시 표시
		document.getElementById('imageUploadBtn').style.display = 'inline';
	}

	function previewImages(input) {
		var previewContainer = document.getElementById('imagePreviewContainer');
		var files = input.files;

		for (var i = 0; i < files.length; i++) {
			var reader = new FileReader();
			var file = files[i];

			reader.onloadend = (function(index) {
				return function() {
					var img = document.createElement('img');
					img.src = reader.result;
					img.className = 'preview-image';
					previewContainer.appendChild(img);

					var cancelBtn = document.createElement('button');
					cancelBtn.innerHTML = '현재 이미지 삭제';
					cancelBtn.className = 'btn btn-danger cancel-btn';
					cancelBtn.onclick = function() {
						cancelImageUpload(index);
					};

					previewContainer.appendChild(cancelBtn);
				};
			})(i);

			if (file) {
				reader.readAsDataURL(file);
			}
		}

		// 이미지 추가 버튼을 숨김
		document.getElementById('imageUploadBtn').style.display = 'none';
	}
	

function calculateDiscount() {
    // 정가와 판매가 값을 가져옴
    var regularPrice = parseFloat(document.getElementById('original_price').value);
    var salePrice = parseFloat(document.getElementById('discount_price').value);

    // 수량을 가져옴
    var quantity = parseInt(document.getElementById('result').textContent);

    // 정가와 판매가가 유효한 숫자인 경우에만 계산 수행
    if (!isNaN(regularPrice) && !isNaN(salePrice)) {
        // 할인율 계산
        var discount = ((regularPrice - salePrice) / regularPrice) * 100;

        // 할인가 계산 (수량만큼 곱하기)
        var discountedPrice = salePrice * quantity;

        // 계산된 할인율을 할인율 입력란에 표시
        document.getElementById('discount_rate').value = discount.toFixed(0);

        // 할인가를 동적으로 표시할 span 업데이트
        document.getElementById('discountPriceDisplay').textContent = '총금액: ' + discountedPrice.toFixed(0)+ '원';
    } else {
        // 정가나 판매가가 유효한 숫자가 아닌 경우 할인율 입력란을 비움
        document.getElementById('discount_rate').value = '';
    }
}

$(document).ready(function () {
    // Get the initial value of the result
    var result = parseInt($("#result").text());

    // Handle the plus button click
    $(".plus").on("click", function () {
        result += 1;
        $("#result").text(result);
        // Recalculate discount when quantity changes
        calculateDiscount();
    });

    // Handle the minus button click
    $(".minus").on("click", function () {
        // Make sure the result is greater than 1 before decrementing
        if (result > 1) {
            result -= 1;
            $("#result").text(result);
            // Recalculate discount when quantity changes
            calculateDiscount();
        }
    });
});

	

	
</script>
</script>

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

.preview-image {
	max-width: 100%;
	max-height: 100%;
	margin: 10px;
}
</style>

<body>

	<div class="container" style="max-width: 900px; height: 100px;">
		<jsp:include page="../include/header.jsp" />

		<br>
		<form class="form-inline" method="get"
			action="${contextPath}/OrderPage">
			<input type="hidden" id="product_idx" name="product_idx"
				value="${productDetail.product_idx}" />
			<div class="row" style="max-width: 890px; height: 100px;">
				<div class="row top text-dark">
					<input type="text" name="product_Name" readonly id="product_Name"
						value="${productDetail.product_name }" class="form-control"
						placeholder="제품 이름">
				</div>
			</div>





			<!-- MIDDLE -->
			<div class="row middle">


				<div class="col-md-6 middle-left"
					style="height: 422px; display: flex; align-items: center; justify-content: center;">
					<div class="panel-body">
						<!-- 실질 파일업로드 할수 있는 인반문자열, 바이너리 데이터 필요 -->
						<!--  <form action="${contextPath}/memImageUpdate" method="post"
            enctype="multipart/form-data">-->

						<input type="hidden" name="memID" value="${mvo.memID}" />
						<table class="table table-bordered"
							style="text-align: center; border: 1px solid #dddddd;">
							<div class="col-sm-6 col-md-4" style="width: 440px; ">
								<div class="card-ui">
									<div class="thumbnail">
										<img
											src="${contextPath}/resources/upload/${productDetail.thumbnail_img}"
											alt="thumbnail_img">
									</div>
								</div>
							</div>

						</table>
						<!--</form>-->
					</div>
				</div>

				<div class="col-md-6 middle-right text-dark">

					<div class="row middle-right-1">
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">판매자</td> <br>
							<input type="text" value="${mvo.memName}" readonly />

						</div>
						<div class="col-md-6">
							<td style="vertical-align: middle;">등록상태</td> <br> <select
								id="cars" name="cars" style="width: 185px; height: 28px;">
								<option value="volvo">마감</option>
								<option value="saab">판매중</option>
							</select>

						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">마감일</td> <br>
							<input type="text" id="selectedDateTime" name="end_date" readonly
								onchange="calculateTimeDifference()" value="${productDetail.end_date }" >
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">카테고리</td> <br>
							<input type="text" />
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">정가</td> <br>
							<input type="text" name="original_price" id="original_price"
								readonly value="${productDetail.original_price }"
								onchange="calculateDiscount()" />
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">할인가</td> <br>
							<input type="text" name="discount_price" id="discount_price"
								value="${productDetail.discount_price }" readonly
								onchange="calculateDiscount()" />
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">할인율</td> <br>
							<input type="text" name="discount_rate" id="discount_rate"
								value="${productDetail.discount_rate }" readonly
								onchange="calculateDiscount()" />
						</div>





					</div>
					<div class="row middle-right-2 text-dark">
						<div class="col-12">
						<input type="text" id="end_date" name="end_date" value="${productDetail.end_date}">
						</div>
					</div>
					<div class="row middle-right-3 text-dark">

						<div class="num">
							<span>수량</span> <span class="count"> <a href="#"
								class="minus">-</a> <span id="result">1</span> <a href="#"
								class="plus">+</a>
							</span>
							<div id="discountPriceDisplay"></div>
						</div>

						<input type="submit" class="btn btn-primary btn-sm pull-right"
							value="주문하기" />
							<a href="${contextPath}/ProductModify?product_idx=${productDetail.product_idx}">상품정보수정</a><br>
							<a href="${contextPath}/ProductDelete?product_idx=${productDetail.product_idx}">상품삭제</a>

					</div>

				</div>


			</div>
			<hr>
			상품상세

			<div class="row bottom text-dark">
				<div class="panel panel-default">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#home">상품상세</a></li>
						<li><a data-toggle="tab" href="#menu1">판매자정보</a></li>
						<li><a data-toggle="tab" href="#menu2">공지사항</a></li>
					</ul>
					<div class="tab-content">
						<div id="home" class="tab-pane fade in active">
							<h3>HOME</h3>



							<div class="panel-body">
								<!-- 실질 파일업로드 할수 있는 인반문자열 , 바이너리 데이터 필요 -->
								<!--  <form action="${contextPath}/memImageUpdate" method="post"
						enctype="multipart/form-data">-->

								<input type="hidden" name="memID" value="${mvo.memID }" />
								<table class="table table-bordered"
									style="text-align: center; border: 1px solid #dddddd;">
									<tr>
										<td colspan="2" id="imagePreviewContainer"></td>
									</tr>
									<div class="thumbnail">
										<img
											src="${contextPath}/resources/upload/${productDetail.detail_img}"
											alt="detail_img">
									</div>
								</table>
								<!--</form>-->
							</div>


						</div>
						<div id="menu1" class="tab-pane fade">
							<h3>게시판</h3>
							<p>Some content in menu 1.</p>

						</div>
						<div id="menu2" class="tab-pane fade">
							<h3>공지사항</h3>
							<p>Some content in menu 2.</p>
						</div>
					</div>
				</div>









			</div>
			<br>
		</form>
	</div>





</body>

</html>