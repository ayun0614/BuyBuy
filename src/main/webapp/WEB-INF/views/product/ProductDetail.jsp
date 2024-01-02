<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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



var countDownDate_${productDetail.product_idx} = new Date("${productDetail.end_date}").getTime();

//Update the countdown every 1 second
var x_${productDetail.product_idx} = setInterval(function () {
 // Get the current date and time
 var now = new Date().getTime();

 // Calculate the remaining time
 var distance = countDownDate_${productDetail.product_idx} - now;

 // Calculate days, hours, minutes, and seconds
 var days = Math.floor(distance / (1000 * 60 * 60 * 24));
 var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
 var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
 var seconds = Math.floor((distance % (1000 * 60)) / 1000);

 // Display the countdown with different styles based on remaining time
 var countdownElement = document.getElementById("countdown_${productDetail.product_idx}");
 if (distance < 0) {
     clearInterval(x_${productDetail.product_idx});
     countdownElement.innerHTML = "공구종료";
     if ('${productDetail.content_state}' === '판매중') {
         alert("마감");
         ProductTimeout();
     }
     $(".btn-primary.btn-sm.pull-right").hide();
 } else {
     var countdownText = days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초 ";
     countdownElement.innerHTML = countdownText;

     // Change text color to red if remaining time is 30 minutes or less
     if (days === 0 && hours <=12) {
         countdownElement.style.color = "blue";
     } else {
         countdownElement.style.color = ""; // Reset to default color
     }
 }
}, 1000);

function ProductTimeout() {
   
   window.location.href = "${contextPath}/product/ProductTimeout?product_idx=${productDetail.product_idx}";
    
}
$(document).ready(function () {
    // Get the initial value of the result
    var result = parseInt($("#result").text());

    // Function to show alert when count is 10
    function showAlert() {
        alert("최대 수량은 10개까지 가능합니다");
    }

    // Handle the plus button click
    $(".plus").on("click", function () {
        // Check if the result is less than 10 before incrementing
        if (result < 10) {
            result += 1;
            $("#result").text(result);
            // Recalculate discount when quantity changes
            calculateDiscount();
        }

        // Show alert when count is 10
        if (result === 10) {
            showAlert();
        }
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

    // Set the initial state of the plus button based on the quantity
    if (result >= 10) {
        $(".plus").prop("disabled", true);
    }

    $("#discount_price").val("${productDetail.discount_price}");
    calculateDiscount();

    if ("${mvo.member_id}" === "${productDetail.member_id}") {
        $(".btn-primary.btn-sm.pull-right").prop("disabled", true);
    }
});
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
            document.getElementById('discount_rate').value = discount.toFixed(0) + '%';

            // 할인가를 동적으로 표시할 span 업데이트
            document.getElementById('discountPriceDisplay').textContent = '총금액: ' + discountedPrice.toFixed(0) + '원';
        } else {
            // 정가나 판매가가 유효한 숫자가 아닌 경우 할인율 입력란을 비움
            document.getElementById('discount_rate').value = '';
        }
    }
    
    function reply(replyFormId) {
        $("#" + replyFormId).toggle();
    }
    function validateForm() {
        var memberId = "${mvo.member_id}";

        if (memberId === "") {
            // mvo.member_id가 없는 경우 로그인 페이지로 이동
            alert("로그인후 이용이 가능합니다.")
            window.location.href = "${contextPath}/account/signIn";
            return false; // 폼 제출을 막음
        }

        // mvo.member_id가 있는 경우 폼을 제출
        return true;
    }
    function productBuy() {
        var result = $("#result").text();
        $("#order_pcs").val(result);
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
     object-fit: cover;
}

.nav-tabs li {
   width: 33.33%;
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
       <form action="productBuy" method="get" onsubmit="return validateForm()" enctype="multipart/form-data">
         
         <input type="hidden" id="endDate" value="${product.end_date}">
         <input type="hidden" id="product_idx" name="product_idx"
            value="${productDetail.product_idx}" /> <a
            href="${contextPath}/product/ProductList" style="font-size: 20px;">
            <span class="glyphicon glyphicon-chevron-left"></span>돌아가기
         </a> <br> <br>
         <div class="row" style="max-width: 890px; height: 100px;">
            <div class="row top text-dark" style="border-radius: 30px;">
               <input type="text" name="product_name" readonly style="text-align:center;"
                  class="form-control" value="${productDetail.product_name}"
                  placeholder="제품 이름">
            </div>
         </div>
         <!-- MIDDLE -->
         <div class="row middle" style="height: 400px; text-align: center;">
            <div class="row"
               style="border: 1px solid black; border-radius: 30px; height: 450px;">
            <div class="col-md-6" style="border-radius: 30px; width: 450px; height: 435px; overflow: hidden; border: 1px solid black; margin-left: 6px; margin-top: 6px; margin-bottom: 6px;">
    <img id="productThumbnail" src="${productDetail.thumbnail_img}" alt="thumbnail_img" style="width: 100%; height: 100%; object-fit: contain;">
</div>
               <div class="col-md-6">
                  <br>
                  <div>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1"> 판매자 </span> <input
                           type="text" value="${productDetail.name}" readonly
                           style="text-align: center;" class="form-control input-sm"
                           aria-describedby="basic-addon1">
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1" >마감일</span> <input
                           type="datetime-local" name="end_date"
                           style="text-align: center;" class="form-control input-sm"
                           placeholder="마감일" readonly onchange="calculateTimeDifference()"
                           value="${productDetail.end_date}">
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">남은시간</span>
                        <div id="countdown_${productDetail.product_idx}" readonly style="font-weight:bold;"
                           class="form-control input-sm"></div>
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="content_state">상태</span> <input
                           type="text" name="content_state" class="form-control input-sm"
                           style="text-align: center;" readonly
                           value="${productDetail.content_state}">
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon">카테고리</span> <input type="text"
                           class="form-control input-sm" style="text-align: center;"
                           value="${productDetail.ctgr_name}" readonly>
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">정가</span> <input
                           type="text" name="original_price" id="original_price" readonly
                           class="form-control input-sm" placeholder="정가"
                           value="${productDetail.original_price}"
                           style="text-align: center;" aria-describedby="basic-addon1"
                           onchange="calculateDiscount()" />
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">판매가</span> <input
                           type="text" id="discount_price" name="discount_price" readonly
                           class="form-control input-sm" placeholder="판매가"
                           style="text-align: center;"
                           value="${productDetail.discount_price}"
                           aria-describedby="basic-addon1" onchange="calculateDiscount()" />
                     </div>
                     <br>
                     <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">할인율</span> <input
                           type="text" name="discount_rate" id="discount_rate"
                           style="text-align: center;" class="form-control input-sm"
                           placeholder="할인율" readonly
                           value="${productDetail.discount_rate}"
                           aria-describedby="basic-addon1" onchange="calculateDiscount()" />
                     </div>
                     <div class="row">
                        <div class="col-md-4" style="margin-top: 12px;">
                           <div class="num">
                              <spa>수량</span> <span class="count"> 
                              <a href="#" class="btn btn-primary sm minus">-</a> 
                              <span id="result">1</span> 
                              <input type = "hidden" id ="order_pcs" name = "order_pcs" value = "1"/>
                              <a href="#" class="btn btn-primary sm plus" style="margin-right: 5px;">+</a>
                              </span>
                           </div>
                        </div>
                        <div class="col-md-4" style="margin-top: 12px;">
                           <div id="discountPriceDisplay" style="margin-left:-20px; margin-top:3px; width:110px"></div>
                        </div>
                        <div class="col-md-5" style=" display: flex; margin-left:110px; margin-top:-23px;">
                           <c:if test="${!empty mvo}">
                              <c:if test="${productDetail.member_id eq mvo.member_id}">
                                 <!-- 여기에 해당 멤버에게 보여줘야 하는 내용 추가 -->
                                 <a
                                    href="${contextPath}/product/ProductModify?product_idx=${productDetail.product_idx}"
                                    class="btn btn-primary"
                                    style="font-size: 12px; width: 65.5px; height: 29.33px; display: flex; justify-content: center; align-items: center; margin-right: 20px; text-align: center;">게시글수정</a>
                              </c:if>
                           </c:if>
                           <c:if test="${productDetail.content_state eq '판매중'}">
                              <input type="submit" class="btn btn-primary btn-sm pull-right" onclick = "productBuy()"
                                 value="주문하기" />
                           </c:if>
                        </div>
                     </div>
                     <br>
                  </div>
               </div>
            </div>
         </div>
         <br> <br> <br>
         <hr>
         <h3>상품상세</h3>
         <div class="row bottom text-dark">
            <div class="panel panel-default">
               <ul class="nav nav-tabs">
                  <li class="active"><a data-toggle="tab" href="#home">상품상세</a></li>
                  <li><a data-toggle="tab" href="#menu1">판매자정보</a></li>
                  <li><a data-toggle="tab" href="#menu2">상품문의</a></li>
               </ul>
               <div class="tab-content">
                  <div id="home" class="tab-pane fade in active">
                     <div class="panel-body">
                        <table class="table table-bordered"
                           style="text-align: center; border-radius: 30px; border: 1px solid #dddddd;">
                           <tr>
                              <div class="thumbnail">
                                 <img
                                    src="${productDetail.detail_img}"
                                    alt="detail_img">
                              </div>
                           </tr>
                        </table>
                     </div>
                  </div>
                  <div id="menu1" class="tab-pane fade">
                     <h3>판매자정보</h3>
                     <p>
                     <p>
                     <div class="form-group"
                        style="height: 300px; width: 300px; text-align: center; margin: 0 auto;">
                              <address>
                                 <strong>판매자 이름</strong><br> ${productDetail.name }<br>
                              </address>
                                 <address>
                                 <strong>전화번호</strong><br>${productDetail.phone }</a>
                              </address>
                              <address>
                                 <strong>이메일</strong><br> <a href="mailto:#">${productDetail.email }</a>
                              </address>
                              
                              <address>
                                 <strong>사업장 주소</strong><br>${productDetail.addr }</a>
                              </address>
                              <address>
                                 <strong>상세주소</strong><br>${productDetail.detailaddr }</a>
                              </address>
                     </div>

                     </p>
                     </p>
                  </div>
      </form>
      <c:if test="${empty mvo }">
         <div id="menu2" class="tab-pane fade">
            <h3>상품 문의</h3>
            <div>로그인시 사용가능합니다.</div>
            <br>
         </div>
      </c:if>
      <c:if test="${!empty mvo }">
         <div id="menu2" class="tab-pane fade">
            <h3>상품 문의</h3>
            <form id="replyForm" action="${contextPath }/reply" method="post"
               style="padding: 10px; display: flex; align-items: center;">
               <input type="hidden" id="product_idx" name="product_idx"
                  value="${productDetail.product_idx }" /> <input type="hidden"
                  id="member_id" name="member_id" value="${mvo.member_id }" /> <input
                  type="text" id="content" name="content" placeholder="댓글을 입력해주세요"
                  class="form-control" style="margin: 15px;" />
               <button type="submit" id="replyInsertBtn" class="btn btn-default">댓글
                  입력</button>
            </form>

            <table class="table table-hover">
               <tbody>
                  <c:forEach items="${ro3}" var="ro3" varStatus="loop">
                     <tr>
                        <td rowspan="2"
                           style="height: 68px; display: flex; align-items: center;">
                           <div
                              style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin-right: 7px;">
                              <img
                                 src="${ro3.profileimg }"
                                 alt="프로필 이미지"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                           </div>
                           <div
                              style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 5px;">
                              <div>${ro3.member_id}
                                 <fmt:formatDate value="${ro3.content_date}"
                                    pattern="yyyy-MM-dd HH:mm" />
                              </div>
                              <div>${ro3.content}</div>
                           </div>
                           <div style="margin-left: auto;">
                              <c:if
                                 test="${ro3.member_id eq mvo.member_id and ro3.r1state ne 0}">
                                 <button type="button" class="btn btn-danger"
                                    onclick="location.href='${contextPath}/replydelete?reply_idx=${ro3.reply_idx }&product_idx=${ro3.product_idx}'">삭제</button>
                              </c:if>
                              <c:if test="${ro3.r1state ne 0}">
                                 <button type="button" class="btn btn-default"
                                    onclick="reply('reply2Form${loop.index}')" style="">답글
                                    입력</button>
                              </c:if>
                           </div>
                        </td>
                     </tr>
                     <!-- 대댓글 -->
                     <c:forEach items="${ro4}" var="ro4">
                        <c:if test="${ro4.reply_idx eq ro3.reply_idx}">
                           <tr>
                              <td style="height: 68px; display: flex; align-items: center;">
                                 <div
                                    style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin-right: 7px; margin-left: 35px;">
                                    <img
                                       src="${ro4.profileimg }"
                                       alt="프로필 이미지"
                                       style="width: 100%; height: 100%; object-fit: cover;">
                                 </div>
                                 <div
                                    style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 5px;">
                                    <div>${ro4.member_id}
                                       <fmt:formatDate value="${ro4.content2_date}"
                                          pattern="yyyy-MM-dd HH:mm" />
                                    </div>
                                    <div>${ro4.content2}</div>
                                 </div>
                                 <div style="margin-left: auto;">
                                    <c:if
                                       test="${ro4.member_id eq mvo.member_id and ro4.r2state ne 0}">
                                       <button type="button" class="btn btn-danger"
                                          onclick="location.href='${contextPath}/replydelete2?reply2_idx=${ro4.reply2_idx }&product_idx=${ro4.product_idx}'">삭제</button>
                                    </c:if>

                                 </div>
                              </td>
                           </tr>
                        </c:if>
                     </c:forEach>
                     <tr id="reply2Form${loop.index}" style="display: none;">
                        <td>
                           <form action="${contextPath}/reply2" method="post"
                              style="display: flex; align-items: center; justify-content: center;">
                              <input type="hidden" id="member_id" name="member_id"
                                 value="${mvo.member_id}" /> <input type="hidden"
                                 id="reply_idx" name="reply_idx" value="${ro3.reply_idx}" />
                              <input type="hidden" id="product_idx" name="product_idx"
                                 value="${productDetail.product_idx}" /> <input type="text"
                                 name="content2" id="content2" placeholder="답글을 입력해주세요"
                                 class="form-control"
                                 style="width: 700px; margin-right: 10px; text-align: left; margin-left: auto;">
                              <button type="submit" class="btn btn-default"
                                 style="margin-left: auto;">입력</button>
                           </form>
                        </td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
         </div>
      </c:if>
   </div>

</body>
</html>