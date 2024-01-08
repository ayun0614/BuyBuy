<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
   <c:import url="include/chat.jsp" />
   <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
   <div class="slider-container container">
      <div class="slider-show">
         <c:forEach var="list" items="${bannerList }">
            <div>
               <a href="${list.banner_url }"> <img class="main-slickImg" alt="" src="${list.image_url}">
                  <h3 class="slick-name">${list.banner_name }</h3>
                  <h3 class="slick-text">${list.banner_text }</h3> </img>
               </a>
            </div>
         </c:forEach>
      </div>
      <div class="slick-status">
         <h3>1</h3>
         <h4>/ ${bannerCount }</h4>
      </div>
      <button class="slick-prevBtn"><</button>
      <button class="slick-nextBtn">></button>
   </div>
   <div class="product-container container">
      <h3 class="product-header">인기 공동구매 상품</h3>
      <div class="product-flex">
         <c:forEach var="list" items="${popList }">
            <div>
               <c:if test="${list.thumbnail_img eq null}">
                  <img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg" onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">
               </c:if>
               <c:if test="${list.thumbnail_img ne null }">
                  <img class="product-image" alt="" src="${list.thumbnail_img }" onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">
               </c:if>
               <h1 onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=${list.ctgr_idx }'">
                  <c:choose>
                     <c:when test="${list.ctgr_idx eq 1 }">의류</c:when>
                     <c:when test="${list.ctgr_idx eq 5 }">화장품</c:when>
                     <c:when test="${list.ctgr_idx eq 9 }">식품</c:when>
                     <c:when test="${list.ctgr_idx eq 13 }">생필품</c:when>
                     <c:when test="${list.ctgr_idx eq 2 }">홈데코</c:when>
                     <c:when test="${list.ctgr_idx eq 6 }">문구</c:when>
                     <c:when test="${list.ctgr_idx eq 10 }">취미</c:when>
                     <c:when test="${list.ctgr_idx eq 14 }">반려동물</c:when>
                     <c:when test="${list.ctgr_idx eq 3 }">컴퓨터</c:when>
                     <c:when test="${list.ctgr_idx eq 7 }">모바일</c:when>
                     <c:when test="${list.ctgr_idx eq 11 }">가전제품</c:when>
                     <c:when test="${list.ctgr_idx eq 15 }">스포츠</c:when>
                     <c:when test="${list.ctgr_idx eq 4 }">건강</c:when>
                     <c:when test="${list.ctgr_idx eq 8 }">공구</c:when>
                     <c:when test="${list.ctgr_idx eq 12 }">기타</c:when>
                  </c:choose>
               </h1>
               <h2 onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">${list.product_name }</h2>
               <h3>${list.discount_price }원</h3>
               <h4>${list.original_price }원</h4>
               <h5 id="pop_${list.product_idx}"></h5>
            </div>
            <script>
                 // Set the date we're counting down to
                 var pop_${list.product_idx} = new Date("${list.end_date}").getTime();
         
                 // Update the countdown every 1 second
                 var x_${list.product_idx} = setInterval(function () {
                     // Get the current date and time
                     var now = new Date().getTime();
         
                     // Calculate the remaining time
                     var distance = pop_${list.product_idx} - now;
         
                     // Calculate days, hours, minutes, and seconds
                     var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                     var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                     var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                  
                     // Display the countdown
                     document.getElementById("pop_${list.product_idx}").innerHTML =
                         days + "D " + hours + "H " + minutes + "M";
                     // If the countdown is over, display a message
                     if (distance < 0) {
                         clearInterval(x_${list.product_idx});
                         document.getElementById("pop_${list.product_idx}").innerHTML =
                             "공구종료";
                     }
                 }, 1000);
             </script>
         </c:forEach>
         <c:if test="${fn:length(popList) lt 4}">
            <c:forEach var="empty1" begin="${fn:length(popList) }" end="3" step="1">
               <img style="width: 250px;" alt="" src="${contextPath }/resources/image/product_none.png">
            </c:forEach>
         </c:if>
      </div>
   </div>
   <div class="product-container container">
      <h3 class="product-header">신규 등록 상품</h3>
      <div class="product-flex">
         <c:forEach var="list" items="${newList }">
            <div>
               <c:if test="${list.thumbnail_img eq null}">
                  <img class="product-image" alt="" src="${contextPath }/resources/image/product-empty.jpg" onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">
               </c:if>
               <c:if test="${list.thumbnail_img ne null }">
                  <img class="product-image" alt="" src="${list.thumbnail_img }" onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">
               </c:if>
               <h1 onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=${list.ctgr_idx }'">
                  <c:choose>
                     <c:when test="${list.ctgr_idx eq 1 }">의류</c:when>
                     <c:when test="${list.ctgr_idx eq 5 }">화장품</c:when>
                     <c:when test="${list.ctgr_idx eq 9 }">식품</c:when>
                     <c:when test="${list.ctgr_idx eq 13 }">생필품</c:when>
                     <c:when test="${list.ctgr_idx eq 2 }">홈데코</c:when>
                     <c:when test="${list.ctgr_idx eq 6 }">문구</c:when>
                     <c:when test="${list.ctgr_idx eq 10 }">취미</c:when>
                     <c:when test="${list.ctgr_idx eq 14 }">반려동물</c:when>
                     <c:when test="${list.ctgr_idx eq 3 }">컴퓨터</c:when>
                     <c:when test="${list.ctgr_idx eq 7 }">모바일</c:when>
                     <c:when test="${list.ctgr_idx eq 11 }">가전제품</c:when>
                     <c:when test="${list.ctgr_idx eq 15 }">스포츠</c:when>
                     <c:when test="${list.ctgr_idx eq 4 }">건강</c:when>
                     <c:when test="${list.ctgr_idx eq 8 }">공구</c:when>
                     <c:when test="${list.ctgr_idx eq 12 }">기타</c:when>
                  </c:choose>
               </h1>
               <h2 onclick="location.href='${contextPath}/product/ProductDetail?product_idx=${list.product_idx }'">${list.product_name }</h2>
               <h3>${list.discount_price }원</h3>
               <h4>${list.original_price }원</h4>
               <h5 id="new_${list.product_idx}"></h5>
            </div>
            <script>
                 // Set the date we're counting down to
                 var new_${list.product_idx} = new Date("${list.end_date}").getTime();
         
                 // Update the countdown every 1 second
                 var x_${list.product_idx} = setInterval(function () {
                     // Get the current date and time
                     var now = new Date().getTime();
         
                     // Calculate the remaining time
                     var distance = new_${list.product_idx} - now;
         
                     // Calculate days, hours, minutes, and seconds
                     var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                     var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                     var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                  
                     // Display the countdown
                     document.getElementById("new_${list.product_idx}").innerHTML =
                         days + "D " + hours + "H " + minutes + "M";
                     // If the countdown is over, display a message
                     if (distance < 0) {
                         clearInterval(x_${list.product_idx});
                         document.getElementById("new_${list.product_idx}").innerHTML =
                             "공구종료";
                     }
                 }, 1000);
             </script>
         </c:forEach>
         <c:if test="${fn:length(newList) lt 4}">
            <c:forEach var="empty1" begin="${fn:length(newList) }" end="3" step="1">
               <img style="width: 250px;" alt="" src="${contextPath }/resources/image/product_none.png">
            </c:forEach>
         </c:if>
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