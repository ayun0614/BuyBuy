<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/header.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
   $(document).ready(function() {
      showNotification();

      setInterval(function() {
         showNotification();
      }, 5000);
      $(".header-loginBtn").click(function() {
         location.href = "${contextPath}/account/signIn";
      });

      $(".header-logoutBtn").click(function() {
         location.href = "${contextPath}/account/logout";
      });

      $(".header-searchBtn").click(function() {
         if ($(".header-searchInput").val() != null && $(".header-searchInput").val() != "") {
            location.href = "${contextPath}/product/search?word=" + $(".header-searchInput").val();
         }
      });
      2
      $(".header-searchInput").keyup(function(key) {
         if (key.keyCode == 13) {
            if ($(".header-searchInput").val() != null && $(".header-searchInput").val() != "") {
               location.href = "${contextPath}/product/search?word=" + $(".header-searchInput").val();
            }
         }
      });

      $(".header-pop").click(function() {
         location.href = "${contextPath}/product/pop";
      });

      $(".header-new").click(function() {
         location.href = "${contextPath}/product/new";
      });

      $(".header-soon").click(function() {
         location.href = "${contextPath}/product/soon";
      });

      $(".header-hover").hover(function() {
         $(".header-overlay").css("display", "flex");
      }, function() {
         $(".header-overlay").css("display", "none");
      });
   });
   function showNotification() {
      var notification = document.getElementById("notification");
      var notificationDot = document.getElementById("notificationDot");
      var hasNotification = false;

      $.ajax({
         type : "GET",
         url : "${contextPath}/checkForUpdates",
         data : {
            member_id : "${mvo.member_id}"
         },
         success : function(notifications) {
            updateNotifications(notifications);
         },
         error : function(error) {
            console.error("Error fetching notifications:", error);
         }
      });

      function updateNotifications(notifications) {
         var notificationTable = $("#notificationTable");
         notificationTable.empty();
         var isFirstRow = true;

         notifications
               .forEach(function(ao) {
                  var row = $("<tr>");
                  var url = ao.a_url;

                  if (isFirstRow) {

                     row.append("<div style='font-weight: bold;text-align:left;'>알림</div>");
                     notificationTable.append(row);
                     isFirstRow = false;
                  }

                  row = $("<tr>");
                  row
                        .append("<td style='width: 70px; height: 50px; margin:5px;'><div><img src='"+ao.thumbnail_img+"'style='width: 50px; height: 50px; object-fit: cover;border-radius:50%;'></div>"
                              + "<td class='title' style='width: 250px; height: 70px; margin:5px;'>"
                              + "<div style='text-align:left;'><a style='text-decoration: none;' href='"
                              + "${contextPath}/"
                              + ao.a_url
                              + "?member_id="
                              + $("#member_id").val()
                              + "&a_idx="
                              + ao.a_idx
                              + "&product_idx="
                              + ao.product_idx + "'>" + ao.a_title + "</div>" + "<div style='text-align:left;'>" + ao.msg + "</div>" + "</td></a>");

                  row.addClass(ao.a_state === 0 ? "grayed" : "");
                  notificationTable.append(row);
               });

         notifications.forEach(function(ao) {
            var aostate = ao.a_state;
            if (aostate === 1) {
               hasNotification = true;
            }
         });

         notificationDot.style.display = (hasNotification) ? "block" : "none";
      }
   }
   function showNotification1() {
      var notification = document.getElementById("notification");

      notification.style.display = (notification.style.display === "block") ? "none" : "block";
   }
</script>
<div class="header-shadow">
   <div class="container">
      <div class="header-item header-display row">
         <div class="col-md-1 header-itemCenter">
            <a href="${contextPath }/"><img class="header-logo" alt="Main" src="${contextPath }/resources/image/headerLogo.png"></a>
         </div>
         <div class="col-md-10 header-item">
            <div class="header-search header-item">
               <input class="header-searchInput" type="text" placeholder="검색어 입력">
               <button class="header-searchBtn header-icon" type="submit" style="background: url('${contextPath}/resources/image/headerSearchIcon.svg');"></button>
            </div>
         </div>
         <div class="col-md-1 header-item">
            <c:if test="${empty mvo}">
               <button class="header-loginBtn btn" style="border-color: black;">Login</button>
            </c:if>
            <c:if test="${!empty mvo}">
               <input type="hidden" id="member_id" name="member_id" value="${mvo.member_id }" />
               <div class="header-profile" style = "display:flex;"> 
                  <button class="header-logoutBtn btn" style="border-color: black; margin-right:10px; margin-left:-100px; margin-top:8px; height: 35px; background-color:#ffffff;">Logout</button>
                  <c:if test="${empty mvo.profileimg}">
                     <!-- 프로필 이미지가 없는 경우 -->
                     <c:if test="${mvo.account_type eq 'user' or mvo.account_type eq 'dealer' }">
                        <a href="${contextPath}/account/myPage?member_id=${mvo.member_id}"><img src="${contextPath}/resources/image/kakaotalkimg.jpg" style="width: 50px; height: 50px; border-radius: 50%;" /></a>
                     </c:if>
                     <c:if test="${mvo.account_type eq 'admin' }">
                        <a href="${contextPath }/admin/admin"><img src="${contextPath}/resources/image/kakaotalkimg.jpg" style="width: 50px; height: 50px; border-radius: 50%;" /></a>
                     </c:if>
                  </c:if>
                  <c:if test="${!empty mvo.profileimg}">
                     <!-- 프로필 이미지가 있는 경우 -->
                     <c:if test="${mvo.account_type eq 'user' or mvo.account_type eq 'dealer' }">
                        <a href="${contextPath}/account/myPage?member_id=${mvo.member_id}"><img src="${mvo.profileimg }" style="width: 50px; height: 50px; border-radius: 50%;" /></a>
                     </c:if>
                     <c:if test="${mvo.account_type eq 'admin' }">
                        <a href="${contextPath }/admin/admin"><img src="${mvo.profileimg }" style="width: 50px; height: 50px; border-radius: 50%;" /></a>
                     </c:if>
                  </c:if>
                 
               </div>
            </c:if>
         </div>
      </div>
   </div>
   <div class="container">
      <div class="row">
         <div class="col-md-12"> 
         <div> 
            <div class="header-hover header-menu header-second">
               <img class="header-icon" alt="" src="${contextPath }/resources/image/headerMenu.svg" /> 카테고리
            </div>
            <div class="header-pop header-second">인기</div>
            <div class="header-new header-second">신규</div>
            <div class="header-soon header-second" style = "margin-right:692px;">마감임박</div>
            <span> 
             	<button id="bell" class="glyphicon glyphicon-bell btn-lg" onclick="showNotification1()">
                     <div id="notification"> 
                        <table id="notificationTable"></table> 
                     </div>
                     <div id="notificationDot"></div>
	             </button>
	         </span>
	         </div>
	      </div>
	   </div>
	</div>
<div class="header-hover header-overlay header-shadow menu-box">
   <div class="menu-grid col-md-6"></div>
   <div class="menu-grid col-md-5">
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=1'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuCloth.svg" /> 의류
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=5'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuCosmetics.svg" /> 화장품
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=9'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuFood.svg" /> 식품
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=13'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuDaily.svg" /> 생필품
      </div>
   </div>
   <div class="menu-grid col-md-5">
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=2'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuDeco.svg" /> 홈데코
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=6'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuPencil.svg" /> 문구
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=10'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuHobby.svg" /> 취미
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=14'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuPet.svg" /> 반려동물
      </div>
   </div>
   <div class="menu-grid col-md-5">
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=3'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuComputer.svg" /> 컴퓨터
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=7'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuMobile.svg" /> 모바일
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=11'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuTv.svg" /> 가전제품
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=15'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuSport.svg" /> 스포츠
      </div>
   </div>
   <div class="menu-grid col-md-5">
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=4'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuHealth.svg" /> 건강
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=8'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuTools.svg" /> 공구
      </div>
      <div class="menu-item" onclick="location.href='${contextPath}/product/ProductList?ctgr_idx=12'">
         <img class="menu-icon" alt="" src="${contextPath }/resources/image/menuOthers.svg" /> 기타
      </div>
      <div class="menu-item">
         <h2></h2>
      </div>
   </div>
   <div class="menu-grid col-md-6"></div>
</div>
</div>