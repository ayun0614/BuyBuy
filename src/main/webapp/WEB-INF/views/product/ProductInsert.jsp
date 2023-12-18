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
            document.getElementById('discount_rate').value = discount.toFixed(0);
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
		<jsp:include page="include/header.jsp" />

		<br>
		<form action="${contextPath}/ProductListInsert" method="post"
			enctype="multipart/form-data">


			<!--  <input type="hidden" name="Product_IDX" value="${ProductList.Product_IDX}" />-->
			<div class="row" style="max-width: 890px; height: 100px;">
				<div class="row top text-dark">
					<input type="text" name="product_name" id="product_name"
						class="form-control" placeholder="제품 이름">
				</div>
			</div>

			<!-- MIDDLE -->
			<div class="row middle">

				<div class="col-md-6 middle-left"
					style="height: 389px; display: flex; align-items: center; justify-content: center;">
					<div class="panel-body">
						<input type="hidden" name="memID" value="${mvo.memID}" />
						<table class="table table-bordered"
							style="text-align: center; border: 1px solid #dddddd;">
							<tr>
								<td><span class="btn btn-default"> 이미지 업로드하세요 <input
										type="file" name="thumbnail_img" multiple
										onchange="previewImages(this)" />
								</span></td>
							</tr>
						</table>
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
								<option value="end">마감</option>
								<option value="sale">판매중</option>
							</select>
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">마감일</td> <br>
							<input type="datetime-local" id="selectedDateTime"
								name="end_date" onchange="calculateTimeDifference()">
						</div>
						<div class="col-md-6">
							<td style="vertical-align: middle;">카테고리</td> <br> <select
								id="ctgr_idx" name="ctgr_idx"
								style="width: 185px; height: 28px;">
								<option value="1">의류</option>
								<option value="2">화장품</option>
								<option value="3">식품</option>
								<option value="4">생필품</option>
								<option value="5">홈데코</option>
								<option value="6">문구</option>
								<option value="7">취미</option>
								<option value="8">반려용품</option>
								<option value="9">컴퓨터</option>
								<option value="10">모바일</option>
								<option value="11">가전제품</option>
								<option value="12">스포츠</option>
								<option value="13">건강</option>
								<option value="14">공구</option>
								<option value="15">기타</option>
							</select>
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">정가</td> <br>
							<input type="text" name="original_price" id="original_price"
								onchange="calculateDiscount()" />
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">판매가</td> <br>
							<input type="text" name="discount_price" id="discount_price"
								onchange="calculateDiscount()" />
						</div>
						<div class="col-md-6">
							<td style="width: 50px; vertical-align: middle;">할인율</td> <br>
							<input type="text" name="discount_rate" id="discount_rate"
								onchange="calculateDiscount()" />
						</div>
					</div>
					<div class="row middle-right-2 text-dark">
						<div class="col-12">
							<div class="row middle-right-2 text-dark">
								<div class="col-12" id="timerResult"></div>
							</div>
						</div>
					</div>
					<div class="row middle-right-3 text-dark">
						<div class="col-12">RANDOM</div>
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
								<input type="hidden" name="memID" value="${mvo.memID }" />
								<table class="table table-bordered"
									style="text-align: center; border: 1px solid #dddddd;">
									<tr>
										<td colspan="2" id="imagePreviewContainer"></td>
									</tr>
									<tr>
										<form action="#" method="post" enctype="multipart/form-data">
											<textarea name="text" id="editor"></textarea>
										</form>

										<script>
        ClassicEditor
            .create(
                document.querySelector('#editor'),
                {
                    ckfinder: {
                        uploadUrl: '/uploadImage' // 이미지 업로드를 처리할 URL 지정
                    },
                    toolbar: ['imageUpload']
                }
            )
            .then(editor => {
                // 이미지 업로드 버튼 클릭 시
                editor.ui.getEditableElement().parentElement.insertBefore(
                    editor.ui.view.toolbar.element,
                    editor.ui.getEditableElement()
                );
            })
            .catch(error => {
                console.error(error);
            });
    </script>
										<td><span class="btn btn-default"> 이미지 업로드하세요 <input
												type="file" name="detail_img" multiple
												onchange="previewImages(this)" />
										</span></td>
									</tr>
								</table>
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
			<div style="text-align: center" width="300px";>
				<input type="submit" class="btn btn-primary btn-sm pull-right"
					value="등록하기" />
			</div>
		</form>
	</div>
</body>
</html>