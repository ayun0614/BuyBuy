<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/header.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function() {
		$(".header-loginBtn").click(function() {
			location.href = "${contextPath}/account/login";
		});

		$(".header-searchBtn").click(function() {
			location.href = "${contextPath}/include/search?word=" + $(".header-searchInput").val();
		});
		2
		$(".header-searchInput").keyup(function(key) {
			if (key.keyCode == 13) {
				location.href = "${contextPath}/include/search?word=" + $(".header-searchInput").val();
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
				<button class="header-loginBtn btn">Login</button>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="header-hover header-menu header-second">
					<img class="header-icon" style="margin-right: -3px; margin-top: -5px;" alt="" src="${contextPath }/resources/image/headerMenu.svg" /> 카테고리
				</div>
				<div class="header-pop header-second">인기</div>
				<div class="header-new header-second">신규</div>
				<div class="header-soon header-second">마감임박</div>
			</div>
		</div>
	</div>
	<div class="header-hover header-overlay header-shadow menu-box">
		<div class="menu-grid col-md-6"></div>
		<div class="menu-grid col-md-5">
			<div  class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuCloth.svg" /> 의류
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuCosmetics.svg" /> 화장품
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuFood.svg" /> 식품
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuDaily.svg" /> 생필품
			</div>
		</div>
		<div class="menu-grid col-md-5">
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuDeco.svg" /> 홈데코
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuPencil.svg" /> 문구
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuHobby.svg" /> 취미
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuPet.svg" /> 반려동물
			</div>
		</div>
		<div class="menu-grid col-md-5">
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuComputer.svg" /> 컴퓨터
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuMobile.svg" /> 모바일
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuTv.svg" /> 가전제품
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuSport.svg" /> 스포츠
			</div>
		</div>
		<div class="menu-grid col-md-5">
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuHealth.svg" /> 건강
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuTools.svg" /> 공구
			</div>
			<div class="menu-item">
				<img class="menu-icon" alt="" src="${contextPath }/resources/image/menuOthers.svg" /> 기타
			</div>
			<div class="menu-item">
				<h2></h2>
			</div>
		</div>
		<div class="menu-grid col-md-6"></div>
	</div>
</div>