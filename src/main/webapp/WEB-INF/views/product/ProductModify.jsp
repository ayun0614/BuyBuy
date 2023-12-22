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
	function cancelImageUploadDetail(index) {
		var previewContainer = document
				.getElementById('imagePreviewContainerDetail');
		var filesInput = document.getElementsByName('detail_img')[0]; // Use getElementsByName to get the file input
		var images = previewContainer.getElementsByClassName('preview-image');
		var buttons = previewContainer.getElementsByClassName('cancel-btn');

		// 미리보기 이미지와 버튼을 삭제
		previewContainer.removeChild(images[index]);
		previewContainer.removeChild(buttons[index]);

		// 선택한 이미지를 파일 입력에서도 삭제
		filesInput.value = '';

		// 이미지 추가 버튼을 다시 표시
		document.getElementById('imageUploadBtnDetail').style.display = 'inline';
	}

	function previewImagesDetail(input) {
		var previewContainer = document
				.getElementById('imagePreviewContainerDetail');
		var files = input.files;

		// 기존 미리보기 이미지 및 버튼 삭제
		previewContainer.innerHTML = '';

		for (var i = 0; i < files.length; i++) {
			var reader = new FileReader();
			var file = files[i];

			reader.onloadend = (function(index) {
				return function() {
					var img = document.createElement('img');
					img.src = reader.result;
					img.className = 'preview-image';
					img.style.width = '800px';
					img.style.height = '500px';
					previewContainer.appendChild(img);

					var cancelBtn = document.createElement('button');
					cancelBtn.innerHTML = '현재 이미지 삭제';
					cancelBtn.className = 'btn btn-danger cancel-btn';
					cancelBtn.onclick = function() {
						cancelImageUploadDetail(index);
					};

					previewContainer.appendChild(cancelBtn);
				};
			})(i);

			if (file) {
				reader.readAsDataURL(file);
			}
		}

		// 이미지 추가 버튼을 숨김
		document.getElementById('imageUploadBtnDetail').style.display = 'none';
	}
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
					.toFixed(0)
					+ '%';
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
					img.style.width = '800px';
					img.style.height = '500px';
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
	function cancelImageUpload2(index) {
		var previewContainer = document
				.getElementById('imagePreviewContainer2');
		var filesInput = document.getElementsByName('thumbnail_img')[0];
		var images = previewContainer.getElementsByClassName('preview-image');
		var buttons = previewContainer.getElementsByClassName('cancel-btn');

		// 인덱스가 요소 범위 내에 있는지 확인
		if (index >= 0 && index < images.length) {
			// 미리보기 이미지 및 버튼 삭제
			previewContainer.removeChild(images[index]);
			previewContainer.removeChild(buttons[index]);
		}

		// 파일 입력 값 초기화
		filesInput.value = '';

		// 이미지 업로드 버튼 표시
		document.getElementById('imageUploadBtn').style.display = 'inline';
	}

	function previewImages2(input) {
		var previewContainer = document
				.getElementById('imagePreviewContainer2');
		var files = input.files;

		// 미리보기 컨테이너의 기존 내용 지우기
		previewContainer.innerHTML = '';

		for (var i = 0; i < files.length; i++) {
			var reader = new FileReader();
			var file = files[i];

			reader.onloadend = (function(index) {
				return function() {
					var img = document.createElement('img');
					img.src = reader.result;
					img.className = 'preview-image';
					previewContainer.appendChild(img);

				};
			})(i);

			if (file) {
				reader.readAsDataURL(file);
			}
		}

		// 이미지 업로드 버튼 숨기기
		document.getElementById('imageUploadBtn').style.display = 'none';
	}
	function confirmLeave() {
		var isConfirmed = confirm("수정중인 내용은 저장되지 않습니다. 그래도 돌아가시겠습니까?");
		if (isConfirmed) {
			window.location.href = "${contextPath}/ProductDetail?product_idx=${ProductModify.product_idx}";
		}
	}

	// 페이지 떠나기 전에 확인 메시지 표시
	window.onbeforeunload = function() {
		return "수정중인 내용은 저장되지 않습니다. 그래도 돌아가시겠습니까?";
	};
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

.nav-tabs li {
	width: 33.33%;
	text-align: center;
}
</style>

<body>
	<jsp:include page="../include/header.jsp" />

	<div class="container" style="max-width: 900px; height: 100px;">

		<br>
		<form
			action="${contextPath}/ProductModify?product_idx=${ProductModify.product_idx}"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="product_idx"
				value=${ProductModify.product_idx }> 
			
			<div style="display: flex;">
				<a
				href="${contextPath }/ProductDetail?product_idx=${ProductModify.product_idx}"
				style="font-size: 20px;"> <span
				class="glyphicon glyphicon-chevron-left"></span>상세로 돌아가기
			</a>
				<div style="margin-left: 220px;">
					<h3>게시글 수정</h3>
				</div>
			</div><br>

			<div class="row" style="max-width: 890px; height: 100px;">
				<div class="row top text-dark" style="border-radius: 30px;">
					<input type="text" name="product_name" class="form-control"
						value="${ProductModify.product_name}" placeholder="제품 이름">
				</div>
			</div>
			<!-- MIDDLE -->
			<div class="row middle" style="height: 400px; text-align: center;">
				<div class="row"
					style="border: 1px solid black; border-radius: 30px; height: 400px;">
					<div class="col-md-6"
						style="height: 100%; display: flex; flex-direction: column; border-radius: 30px; align-items: center; justify-content: center;">
						<div id="imagePreviewContainer2"
							style="border-radius: 30px; width: 450px; height: 400px; overflow: hidden; border: 1px solid black; margin-top: 6px; margin-bottom: 6px;">
							<img
								src="${contextPath}/resources/upload/${ProductModify.thumbnail_img}"
								alt="thumbnail_img">
						</div>
						<div>
							<input type="file" name="thumbnail_img" multiple
								style="margin-bottom: 6px;" onchange="previewImages2(this)" />
						</div>
					</div>
					<div class="col-md-6">
						<br>

						<div>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1";>판매자</span> <input
									type="text" value="${mvo.name}" readonly
									class="form-control  input-sm" aria-describedby="basic-addon1">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon">상태</span> <select
									value="${productModify.content_state}"
									class="form-control  input-sm" id="content_state"
									name="content_state">

									<option value="판매중">판매중</option>
									<option value="마감">마감</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
								</select>
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">마감일</span> <input
									type="datetime-local" name="end_date"
									class="form-control  input-sm" placeholder="마감일"
									value="${ProductModify.end_date }"
									aria-describedby="basic-addon1"
									onchange="calculateTimeDifference()">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon">카테고리</span> <select
									class="form-control  input-sm" id="ctgr_name" name="ctgr_idx">

									<option value="1">의류</option>
									<option value="2">홈데코</option>
									<option value="3">컴퓨터</option>
									<option value="4">건강</option>
									<option value="5">화장품</option>
									<option value="6">문구</option>
									<option value="7">모바일</option>
									<option value="8">공구</option>
									<option value="9">식품</option>
									<option value="10">취미</option>
									<option value="11">가전제품</option>
									<option value="12">기타</option>
									<option value="13">생필품</option>
									<option value="14">반려용품</option>
									<option value="15">스포츠</option>
								</select>
							</div>
							<br>

							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">정가</span> <input
									type="text" name="original_price" id="original_price"
									class="form-control  input-sm" placeholder="정가"
									value="${ProductModify.original_price }"
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">판매가</span> <input
									type="text" id="discount_price" name="discount_price"
									class="form-control  input-sm" placeholder="판매가"
									value="${ProductModify.discount_price }"
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">할인율</span> <input
									type="text" name="discount_rate" id="discount_rate"
									class="form-control input-sm" placeholder="할인율" readonly
									value="${ProductModify.discount_rate}"
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							
							<div class="col-md-7"></div>
							<div class="col-md-5" style="margin-top:10px;">
									
									
									<a href="${contextPath}/ProductDelete?product_idx=${ProductModify.product_idx}" class="btn btn-danger" style="font-size: 12px; width: 65.5px; height: 29.33px; display: flex; justify-content: center; align-items: center; text-align: center;">게시글삭제</a>
									<input type="submit" class="btn btn-primary btn-sm pull-right" style="margin-top:-30px;"
										value="수정완료" />
								</div>
							
		





						</div>
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
							<div class="panel-body">
								<!-- 실질 파일업로드 할수 있는 인반문자열 , 바이너리 데이터 필요 -->
								<!--  <form action="${contextPath}/memImageUpdate" method="post"
						enctype="multipart/form-data">-->

								<table class="table table-bordered"
									style="text-align: center; border-radius: 30px; border: 1px solid #dddddd;">
									<tr>
										<td colspan="2" id="imagePreviewContainerDetail"><img
											src="${contextPath}/resources/upload/${ProductModify.detail_img}"
											style="width: 800px; height: 400px;" alt="thumbnail_img">
										</td>
									</tr>
									<tr>
										<td><span class="btn btn-default"> <input
												type="file" style="width: 300px;" name="detail_img" multiple
												onchange="previewImagesDetail(this)" />
										</span></td>
									</tr>
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