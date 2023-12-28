<<<<<<< Updated upstream
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
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
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
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
	function validateForm() {
		var endDate = document.getElementsByName('end_date')[0].value;
		var category = document.getElementById('ctgr_idx').value;
		var originalPrice = document.getElementById('original_price').value;
		var discountPrice = document.getElementById('discount_price').value;

		if (endDate === '') {
			alert('마감일을 입력하세요.');
			return false;
		}

		if (category === '') {
			alert('카테고리를 선택하세요.');
			return false;
		}

		if (originalPrice === '') {
			alert('정가를 입력하세요.');
			return false;
		}

		if (discountPrice === '') {
			alert('판매가를 입력하세요.');
			return false;
		}

		return true;
	}
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

#imagePreviewContainer2 img {
	max-width: 100%;
	max-height: 100%;
	margin: 10px;
}

.nav-tabs li {
	width: 50%;
	text-align: center;
}
.input-group .form-control:last-child{
   width: 350px;
}
.input-group-addon:first-child{
   width: 100px;
}
</style>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container" style="max-width: 900px; height: 100px;">
		<br>
		<form action="${contextPath}/product/ProductListInsert" method="post"
			onsubmit="return validateForm()" enctype="multipart/form-data">
			<input type="hidden" id="endDate" value="${product.end_date}">
			<div style="display: flex;">
				<a href="${contextPath }/product/ProductList"
					style="font-size: 20px;"> <span
					class="glyphicon glyphicon-chevron-left"></span>돌아가기
				</a>
				<div style="margin-left: 290px;">
					<h3>게시글 등록</h3>
				</div>
			</div>
			<br>
			<div class="row" style="max-width: 890px; height: 100px;">
				<div class="row top text-dark" style="border-radius: 30px;">
					<input type="text" name="product_name" class="form-control"
						placeholder="제품 이름">
				</div>
			</div>
			<!-- MIDDLE -->
			<div class="row middle" style="height: 400px; text-align: center;">
				<div class="row"
					style="border: 1px solid black; border-radius: 30px; height: 400px;">
					<div class="col-md-6"
						style="height: 100%; display: flex; flex-direction: column; border-radius: 30px; align-items: center; justify-content: center;">
						<div id="imagePreviewContainer2"
							style="border-radius: 30px; width: 450px; height: 400px; overflow: hidden; border: 1px solid black; margin-top: 6px; margin-bottom: 6px;"></div>
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
									type="hidden" name="member_id" id="member_id"
									value="${mvo.member_id}"> <input type="text"
									name="name" value="${mvo.name}" readonly class="form-control"
									aria-describedby="basic-addon1">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">마감일</span> <input
									type="datetime-local" name="end_date" class="form-control"
									placeholder="마감일" aria-describedby="basic-addon1"
									onchange="calculateTimeDifference()">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon">카테고리</span> <select
									class="form-control" id="ctgr_idx" name="ctgr_idx">
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
									class="form-control" placeholder="정가"
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">판매가</span> <input
									type="text" id="discount_price" name="discount_price"
									class="form-control" placeholder="판매가"
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">할인율</span> <input
									type="text" name="discount_rate" id="discount_rate"
									class="form-control" placeholder="할인율" readonly
									aria-describedby="basic-addon1" onchange="calculateDiscount()" />
							</div>
							<br>
							<div style="text-align: center" width="300px";>
								<input type="submit" class="btn btn-primary btn-sm pull-right"
									style="margin-right: 10px;" value="등록하기" />
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

						<li><a data-toggle="tab" href="#menu2">판매자정보</a></li>
					</ul>
					<div class="tab-content">
						<div id="home" class="tab-pane fade in active">
							<div class="panel-body">
								<table class="table table-bordered"
									style="text-align: center; border-radius: 30px; border: 1px solid #dddddd;">
									<tr>
										<td colspan="2" id="imagePreviewContainer"
											style="height: 300px; width: 300px;"></td>
									</tr>
									<tr>
										<td><span class="btn btn-default"> <input
												type="file" style="width: 300px;" name="detail_img" multiple
												onchange="previewImages(this)" />
										</span></td>
									</tr>
								</table>
							</div>
						</div>
						<div id="menu2" class="tab-pane fade">
							<h3>판매자정보</h3>
							<p>
							<div class="form-group" style="height: 300px; width: 300px;">
								<table class="table">
									<tbody>

										<tr>
											<td class="col-sm-5 control-label">이름</td>
											<td class="col-sm-10">
												<p class="form-control-static">${mvo.name}</p>
											</td>
										</tr>

										<tr>
											<td class="col-sm-5 control-label">사업장 주소</td>
											<td class="col-sm-10">
												<p class="form-control-static">${mvo.addr}</p>
											</td>
										</tr>

										<tr>
											<td class="col-sm-5 control-label">상세주소</td>
											<td class="col-sm-10">
												<p class="form-control-static">${mvo.detailaddr}</p>
											</td>
										</tr>

										<tr>
											<td class="col-sm-5 control-label">Email</td>
											<td class="col-sm-10">
												<p class="form-control-static">${mvo.email}</p>
											</td>
										</tr>

										<tr>
											<td class="col-sm-5 control-label">전화번호</td>
											<td class="col-sm-10">
												<p class="form-control-static">${mvo.phone}</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							</p>

						</div>
					</div>
				</div>
			</div>
			<br>
		</form>
	</div>
</body>
</html>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <c:set var="contextPath" value="${pageContext.request.contextPath }" />
      <html>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
      <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      </head>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <link rel="stylesheet" type="text/css" media="screen"
         href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
      <script
         src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
      <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
      <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
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
               document.getElementById('discount_rate').value = discount.toFixed(0) + '%';
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

               reader.onloadend = (function (index) {
                  return function () {
                     var img = document.createElement('img');
                     img.src = reader.result;
                     img.className = 'preview-image';
                     img.style.width = '800px';
                     img.style.height = '500px';
                     previewContainer.appendChild(img);

                     var cancelBtn = document.createElement('button');
                     cancelBtn.innerHTML = '현재 이미지 삭제';
                     cancelBtn.className = 'btn btn-danger cancel-btn';
                     cancelBtn.onclick = function () {
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
            var previewContainer = document.getElementById('imagePreviewContainer2');
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
            var previewContainer = document.getElementById('imagePreviewContainer2');
            var files = input.files;

            // 미리보기 컨테이너의 기존 내용 지우기
            previewContainer.innerHTML = '';

            for (var i = 0; i < files.length; i++) {
               var reader = new FileReader();
               var file = files[i];

               reader.onloadend = (function (index) {
                  return function () {
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
         function validateForm() {
            var endDate = document.getElementsByName('end_date')[0].value;
            var category = document.getElementById('ctgr_idx').value;
            var originalPrice = document.getElementById('original_price').value;
            var discountPrice = document.getElementById('discount_price').value;

            if (endDate === '') {
               alert('마감일을 입력하세요.');
               return false;
            }

            if (category === '') {
               alert('카테고리를 선택하세요.');
               return false;
            }

            if (originalPrice === '') {
               alert('정가를 입력하세요.');
               return false;
            }

            if (discountPrice === '') {
               alert('판매가를 입력하세요.');
               return false;
            }

            return true;
         }
           function getCurrentDateTime() {
                var now = new Date();
                var year = now.getFullYear();
                var month = now.getMonth() + 1; // 월은 0부터 시작하므로 1을 더함
                var day = now.getDate();
                var hours = now.getHours();
                var minutes = now.getMinutes();

                // 날짜와 시간을 형식에 맞게 조합
                var currentDateTime = year + '-' +
                                      (month < 10 ? '0' + month : month) + '-' +
                                      (day < 10 ? '0' + day : day) + 'T' +
                                      (hours < 10 ? '0' + hours : hours) + ':' +
                                      (minutes < 10 ? '0' + minutes : minutes);

                return currentDateTime;
              }

              // 페이지 로드 시에 현재 날짜와 시간을 가져와서 마감일 입력란에 설정
              window.onload = function() {
                document.getElementsByName('end_date')[0].min = getCurrentDateTime();
              };

              // 마감일 변경 시 현재 이전의 시간을 선택하지 못하게 설정
              function calculateTimeDifference() {
                var endDateInput = document.getElementsByName('end_date')[0];
                var currentDateTime = getCurrentDateTime();

                // 현재 이전의 시간을 선택하지 못하게 설정
                endDateInput.min = currentDateTime;
              }
      </script>
      <style>
         .top,
         .middle-left,
         .middle-right,
         .middle-right-1,
         .middle-right-2,
         .middle-right-3,
         .bottom {
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

         #imagePreviewContainer2 img {
            max-width: 100%;
            max-height: 100%;
            margin: 10px;
         }

         .nav-tabs li {
            width: 50%;
            text-align: center;
         }

         .input-group .form-control:last-child {
            width: 350px;
         }

         .input-group-addon:first-child {
            width: 100px;
         }
      </style>

      <body>
         <jsp:include page="../include/header.jsp" />
         <div class="container" style="max-width: 900px; height: 100px;">
            <br>
            <form action="${contextPath}/product/ProductListInsert" method="post" onsubmit="return validateForm()"
               enctype="multipart/form-data">
               <input type="hidden" id="endDate" value="${product.end_date}">
               <div style="display: flex;">
                  <a href="${contextPath }/product/ProductList" style="font-size: 20px;"> <span
                        class="glyphicon glyphicon-chevron-left"></span>돌아가기
                  </a>
                  <div style="margin-left: 290px;">
                     <h3>게시글 등록</h3>
                  </div>
               </div>
               <br>
               <div class="row" style="max-width: 890px; height: 100px;">
                  <div class="row top text-dark" style="border-radius: 30px;">
                     <input type="text" name="product_name" class="form-control" placeholder="제품 이름">
                  </div>
               </div>
               <!-- MIDDLE -->
               <div class="row middle" style="height: 400px; text-align: center;">
                  <div class="row" style="border: 1px solid black; border-radius: 30px; height: 400px;">
                     <div class="col-md-6"
                        style="height: 100%; display: flex; flex-direction: column; border-radius: 30px; align-items: center; justify-content: center;">
                        <div id="imagePreviewContainer2"
                           style="border-radius: 30px; width: 450px; height: 400px; overflow: hidden; border: 1px solid black; margin-top: 6px; margin-bottom: 6px;">
                        </div>
                        <div>
                           <input type="file" name="thumbnail_img" multiple style="margin-bottom: 6px;"
                              onchange="previewImages2(this)" />
                        </div>
                     </div>
                     <div class="col-md-6">
                        <br>
                        <div>
                           <div class="input-group">
                              <span class="input-group-addon" id="basic-addon1" ;>판매자</span> <input
                                 type="hidden" name="member_id" id="member_id" value="${mvo.member_id}">
                              <input type="text" name="name" value="${mvo.name}" readonly class="form-control"
                                 aria-describedby="basic-addon1">
                           </div>
                           <br>
                           <div class="input-group">
                              <span class="input-group-addon" id="basic-addon1">마감일</span>
                              <input type="datetime-local" name="end_date" class="form-control"
                                 placeholder="마감일" aria-describedby="basic-addon1"
                                 onchange="calculateTimeDifference()">
                           </div>
                           <br>
                           <div class="input-group">
                              <span class="input-group-addon">카테고리</span>
                              <select class="form-control" id="ctgr_idx" name="ctgr_idx">
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
                              <span class="input-group-addon" id="basic-addon1">정가</span>
                              <input type="text" name="original_price" id="original_price"
                                 class="form-control" placeholder="정가" aria-describedby="basic-addon1"
                                 onchange="calculateDiscount()" />
                           </div>
                           <br>
                           <div class="input-group">
                              <span class="input-group-addon" id="basic-addon1">판매가</span>
                              <input type="text" id="discount_price" name="discount_price"
                                 class="form-control" placeholder="판매가" aria-describedby="basic-addon1"
                                 onchange="calculateDiscount()" />
                           </div>
                           <br>
                           <div class="input-group">
                              <span class="input-group-addon" id="basic-addon1">할인율</span>
                              <input type="text" name="discount_rate" id="discount_rate" class="form-control"
                                 placeholder="할인율" readonly aria-describedby="basic-addon1"
                                 onchange="calculateDiscount()" />
                           </div>
                           <br>
                           <div style="text-align: center" width="300px" ;>
                              <input type="submit" class="btn btn-primary btn-sm pull-right"
                                 style="margin-right: 10px;" value="등록하기" />
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

                        <li><a data-toggle="tab" href="#menu2">판매자정보</a></li>
                     </ul>
                     <div class="tab-content">
                        <div id="home" class="tab-pane fade in active">
                           <div class="panel-body">
                              <table class="table table-bordered"
                                 style="text-align: center; border-radius: 30px; border: 1px solid #dddddd;">
                                 <tr>
                                    <td colspan="2" id="imagePreviewContainer"
                                       style="height: 300px; width: 300px;"></td>
                                 </tr>
                                 <tr>
                                    <td><span class="btn btn-default">
                                          <input type="file" style="width: 300px;" name="detail_img"
                                             multiple onchange="previewImages(this)" />
                                       </span></td>
                                 </tr>
                              </table>
                           </div>
                        </div>
                        <div id="menu2" class="tab-pane fade">
                           <h3>판매자정보</h3>
                           <p>
                           <div class="form-group" style="height: 300px; width: 300px;">
                              <table class="table">
                                 <tbody>

                                    <tr>
                                       <td class="col-sm-5 control-label">이름</td>
                                       <td class="col-sm-10">
                                          <p class="form-control-static">${mvo.name}</p>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td class="col-sm-5 control-label">사업장 주소</td>
                                       <td class="col-sm-10">
                                          <p class="form-control-static">${mvo.addr}</p>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td class="col-sm-5 control-label">상세주소</td>
                                       <td class="col-sm-10">
                                          <p class="form-control-static">${mvo.detailaddr}</p>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td class="col-sm-5 control-label">Email</td>
                                       <td class="col-sm-10">
                                          <p class="form-control-static">${mvo.email}</p>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td class="col-sm-5 control-label">전화번호</td>
                                       <td class="col-sm-10">
                                          <p class="form-control-static">${mvo.phone}</p>
                                       </td>
                                    </tr>
                                 </tbody>
                              </table>
                           </div>

                           </p>

                        </div>
                     </div>
                  </div>
               </div>
               <br>
            </form>
         </div>
      </body>

      </html>
>>>>>>> Stashed changes
