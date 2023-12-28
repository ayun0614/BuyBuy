<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/myPage.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>BuyBuy</title>
<style>

<<<<<<< Updated upstream
=======
.bodyDiv {
   background-color: #ffffff;
   width: 1000px;
   height: 1000px;
   margin: auto;
}

.myPageSubText {
   font-weight: 900;
   font-size: 32px;
   text-align: center;
   margin-top: 35px;
}

hr {
   height: 1px;
   background-color: #AFAFAF;
   width: 90%;
   margin-top: 40px;
}

.myInfoBox {
   display: flex;
}

.myInfoImgDiv {
   margin-top: 70px;
   margin-left: 140px;
   width: 175px;
   height: 175px;
   border-radius: 50%;
}

.myInfoImg {
   width: 175px;
   height: 175px;
   border-radius: 50%;
}

.myInfotbl {
   margin-top: 120px;
   margin-left: 20px;
   height: 55px;
}

.myInfoEditPage {
   text-align: center;
   margin-top: 115px;
   margin-left: 280px;
}

.orderStatus {
   display: flex;
   margin-left: 119px;
   margin-top: 50px;
   width: 762px;
   height: 113px;
   background-color: #E9F8F9;
   border-radius: 25px 25px 25px 25px;
}

.orderStatustbl {
   text-align: center;
   margin-top: 16.5px;
   margin-left: 51px;
   height: 80px;
}

.orderStatustd {
   font-weight: 900;
   font-size: 20px;
   width: 220px;
}

.hrSec {
   height: 1px;
   background-color: #AFAFAF;
   width: 90%;
   margin-top: 50px;
}

.myPageMoveBox {
   display: flex;
   margin-left: 95px;
}

.myPageMoveDiv {
   text-align: center;
   margin-top: 100px;
   margin-left: 30px;
   margin-right: 30px;
}

.vl {
   margin-top: 40px;
   margin-left: 65px;
   margin-right: 65px;
   border-left: 1px solid #AFAFAF;
   height: 215px;
}
>>>>>>> Stashed changes
</style>
<script>
	$(document).ready(function() {

		$('#dealerChangeReq').click(function() {

			var id = '${mo.member_id }';

			if ('${mo.account_type}' === 'dealer') {
				alert("판매자 계정입니다.");
			} else {

				$.ajax({
					url : "mypage/dealerRequest",
					type : "put",
					data : id,
					success : function(data) {
						alert(id);
						console.log(id);
					},
					error : function(data) {
						alert("이미 신청한 계정입니다.");
						console.log(id);
					}
				});
			}
		});
	});
</script>
</head>
<body>
<<<<<<< Updated upstream
	<c:import url="../include/header.jsp" />
	<div class="bodyDiv">
		<div class="myPageSubText">마이페이지</div>
		<hr>
		<div class="myInfoBox">
			<div class="myInfoImgDiv">
				<img src="" class="myInfoImg" />
			</div>
			<table class="myInfotbl">
				<tr>
					<td style="font-size: 20px;">${mo.name }</td>
					<td style="font-size: 20px;">&nbsp&nbsp | &nbsp&nbsp ${mo.nickname }</td>
				</tr>
				<tr>
					<td colspan="2" id="member_idReq"><br>${mo.member_id }</td>
				</tr>
			</table>
			<div class="myInfoEditPage">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageSettings.png">
					<br>회원 정보 수정
				</a>
			</div>
		</div>
		<div class="orderStatus">
			<table class="orderStatustbl">
				<tr>
					<td class="orderStatustd">주문완료</td>
					<td class="orderStatustd">배송중</td>
					<td class="orderStatustd">배송완료</td>
				</tr>
				<tr>
					<td style="font-size: 20px;">${mvo.count_orderend}</td>
					<td style="font-size: 20px;">${mvo.count_ing}</td>
					<td style="font-size: 20px;">${mvo.count_end}</td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="myPageMoveBox">
			<c:if test="${mo.account_type eq 'user' }">
				<div class="myPageMoveDiv" style="font-size: 20px;">
					<a href="${contextPath }/account/myOrderList" style="text-decoration: none; color: black;">
						<img src="${contextPath }/resources/image/myPageCart.png">
						<br>구매한 상품
					</a>
				</div>
			</c:if>
			<c:if test="${mo.account_type eq 'dealer' }">
				<div class="myPageMoveDiv" style="font-size: 20px;">
					<a href="${contextPath }/account/myProducts" style="text-decoration: none; color: black;">
						<img src="${contextPath }/resources/image/myPageList.png">
						<br>등록한 상품
					</a>
				</div>
			</c:if>
			<div class="vl"></div>
			<div class="myPageMoveDiv" id="dealerChangeReq" style="font-size: 20px;">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageRequest.png">
					<br>판매자 계정 신청
				</a>
			</div>
			<div class="vl"></div>
			<div class="myPageMoveDiv" style="font-size: 20px;">
				<a href="" style="text-decoration: none; color: black;">
					<img src="${contextPath }/resources/image/myPageKey.png">
					<br>계정 탈퇴
				</a>
			</div>
		</div>
	</div>
=======
   <jsp:include page="../include/header.jsp" />
   <input type="hidden" id="member_id" name="member_id" value="${mvo.member_id }">
   <div class="bodyDiv">
      <div class="myPageSubText">마이페이지</div>
      <hr>
      <div class="myInfoBox">
         <div class="myInfoImgDiv">
         <c:if test="${empty mvo.profileimg}">
             <img src="${contextPath}/resources/image/kakaotalkimg.jpg" class="myInfoImg" />
         </c:if>
         <c:if test="${!empty mvo.profileimg}">
             <img src="${mvo.profileimg}" class="myInfoImg" />
         </c:if>
         </div>
         <table class="myInfotbl">
            <tr>
               <td style="font-size: 20px;">${mvo.name }</td>
               <td style="font-size: 20px;">&nbsp&nbsp | &nbsp&nbsp ${mvo.nickname }</td>
            </tr>
            <tr>
               <td colspan="2" id="member_idReq"><br>${mvo.member_id }</td>
            </tr>
         </table>
         <div class="myInfoEditPage">
            <a href="${contextPath}/account/membermodify?member_id=${mvo.member_id}" style="text-decoration: none; color: black;"><img src="${contextPath}/resources/image/Settings.png"><br>회원 정보 수정</a>
         </div>
      </div>
      <div class="orderStatus">
         <table class="orderStatustbl">
            <tr>
               <td class="orderStatustd">주문완료</td>
               <td class="orderStatustd">배송중</td>
               <td class="orderStatustd">배송완료</td>
            </tr>
            <tr>
               <td style="font-size: 20px;">${mvoo.count_orderend}</td>
               <td style="font-size: 20px;">${mvoo.count_ing}</td>
               <td style="font-size: 20px;">${mvoo.count_end}</td>
            </tr>
         </table>
      </div>
      <hr class="hrSec">
      <div class="myPageMoveBox">
         <c:if test="${mvo.account_type eq 'user' }">
            <div class="myPageMoveDiv" style="font-size: 20px;"> 
               <a href="myOrderList?member_id=${mvo.member_id}" style="text-decoration: none; color: black;"><img src="${contextPath}/resources/image/Shopping Cart.png"><br>구매한 상품</a>
            </div>
         </c:if>
         <c:if test="${mvo.account_type eq 'dealer' }">
            <div class="myPageMoveDiv" style="font-size: 20px;">
               <a href="myProducts?member_id=${mvo.member_id}" style="text-decoration: none; color: black;"><img src="${contextPath}/resources/image/Bulleted List.png"><br>등록한 상품</a>
            </div>
         </c:if>
         <div class="vl"></div>
         <div class="myPageMoveDiv" id="dealerChangeReq" style="font-size: 20px;">
            <a href="" style="text-decoration: none; color: black;"><img src="${contextPath}/resources/image/User Male.png"><br>판매자 계정 신청</a>
         </div>
         <div class="vl"></div>
         <div class="myPageMoveDiv" style="font-size: 20px;">
            <a href="${contextPath}/account/memberdelete?member_id=${mvo.member_id}" style="text-decoration: none; color: black;"><img src="${contextPath}/resources/image/Key.png"><br>계정 탈퇴</a>
         </div>
      </div>
   </div>
>>>>>>> Stashed changes
</body>
</html>