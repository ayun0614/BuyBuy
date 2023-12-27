<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
const userCode = "imp14397622";
IMP.init(userCode);

function requestPay() {
	
	var member_id = $("#member_id").val();
	var deli_name = $("#buyerInfoNameInput").val();
	var deli_phone = $("#buyerInfoTelInput").val();
	var deli_zipcode = $("#sample6_postcode").val();
	var deli_addr = $("#sample6_address").val();
	var deli_detailaddr = $("#sample6_detailAddress").val();
	var deli_memo = $("#memo option:selected").val();
	var pay_type = $("input[name='optradio']:checked").val();
	
	var total = $("td.lastPayTd").html();
	var regex = /[^0-9]/g;
	var total_price = total.replace(regex, "");

	$.ajax({  
		url:"mypage/productBuy",
		type:"put",
		contentType:'application/json;charset=utf-8',
		data:JSON.stringify({"member_id":member_id, "total_price":total_price,"deli_name":deli_name,"deli_phone":deli_phone,"deli_zipcode":deli_zipcode, "deli_addr":deli_addr, "deli_detailaddr":deli_detailaddr, "deli_memo":deli_memo, "pay_type":pay_type}), 
		success:function(){ 
			alert("성공");
		},
		error:function(){
			alert("error");
		}
	});
	
	if($("#cardpay").is(':checked')) {
		IMP.request_pay({
		    pg: "html5_inicis",
		    pay_method: "card",
		    merchant_uid: "test_lput00zg",
		    name: "테스트 결제",
		    amount: 100,
		    buyer_tel: "010-0000-0000",
		  });
	}
	else if($("#passBookpay").is(':checked')) {
		  IMP.request_pay({
			    pg: "html5_inicis",
			    pay_method: "vbank",
			    merchant_uid: "test_lputfugb",
			    name: "테스트 결제",
			    amount: 100,
			    buyer_name: "포트원",
			    buyer_tel: "010-0000-0000",
			    buyer_email: "buyer@example.com",
			  });
	}
	else if($("#tosspay").is(':checked')) {
		IMP.request_pay({
		    pg: "tosspay",
		    pay_method: "card",
		    merchant_uid: "test_lputgqjf",
		    name: "테스트 결제",
		    amount: 100,
		    buyer_tel: "010-0000-0000",
		  });
	}
	else if($("#giftCardpay").is(':checked')) {
		IMP.request_pay({
		    pg: "html5_inicis",
		    pay_method: "cultureland",
		    merchant_uid: "test_lputhh6r",
		    name: "테스트 결제",
		    amount: 100,
		    buyer_tel: "010-0000-0000",
		  });
	}
	else {
		alert("결제 수단을 선택해 주세요.");
		 
	}
	

}
</script>
<meta charset="UTF-8">
<title>BuyBuy</title>
<style>

html, body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #ffffff;
	height: 100%;
}

.bodyDiv {
	background-color:#ffffff;
	width: 1000px;
	margin: auto;
}

.myPageSubDiv {
	margin-top:35px; 
	display:flex;
}

.backBtn {
	margin-left: 70px;
	width: 24.42px;
	height: 41.39px;
}

.myPageSubText {
	margin-left: 340px;
	font-weight: 900;
	font-size:32px;
	text-align:center;
}
 
hr{
	height:1px;
	background-color:#AFAFAF;
	width:90%;
	margin-top:35px;
}

.productInfoSubText,.userInfoSubText {
	margin-left: 100px;
	margin-top:60px; 
	font-weight: 900;
	font-size:25px;
}

.productInfoBox { 
	display:flex;
}
.productInfoBox2 { 
	margin-left: 20px;
	margin-top:70px; 
}

.productInfoImg{ 
	width:222px; 
	height:222px;
	margin-top:33px; 
	margin-left: 100px;
	background-color:#537FE7;
}
.myInfoImg {
	width:222px;  
	height:222px;
}

.hrSec {
	height:1px;
	background-color:#AFAFAF;
	width:90%;
	margin-top:50px;
}

.buyCheckbox {
	margin-top:60px;
	margin-left: 80px;
}

#buyBtn{
	background-color:#537FE7;
	color: #ffffff;
	width: 840px;
	height: 70px;
	margin-top:20px;   
	margin-bottom:50px;  
}

.paymentRadioGroup {
	margin-left: 120px; 
}
.paymentRadio {
	margin-top:30px;   
	margin-right: 115px;
} 

.paymentRadioDiv {
	display: flex;
	margin-top:40px; 
}
.form-control {
	margin-right: 5px; 
	width: 350px;
}

.userInfoTbl {
	width: 800px; 
	margin-left: 100px;
	margin-top:20px;
}
.userInfoTr {  
	height: 30px;
}
.userInfoTd {
	width: 105px; 
}

.lastPayTextTd {
	font-size: 18px;
	font-weight: 900;
}
.lastPayTd{
	text-align: right;
	font-weight: 900;
	font-size: 18px;
	color: #537FE7;
}

.buyerInfoAdrInputGroup {
	display:flex;
}
 

</style>
<script type="text/javascript">
	$(document).ready(function() {

		$(".paymentRadioDiv").hide();
		$("#buyBtn").attr("disabled", true);
		$("#userInfoNameInput").hide();
		$("#userInfoTelInput").hide();
		$("#userInfoUpdateAfBtn").hide();
		$("#buyerInfoUpdateAfBtn").hide();
		$("#buyerInfoNameInput").hide();
		$("#buyerInfoTelInput").hide();
		$(".buyerInfoAdrInputDiv").hide();

		$(".paymentDivShow").click(function() {
			$(".paymentRadioDiv").show();
		})

		$(".paymentDivHide").click(function() {
			$(".paymentRadioDiv").hide();
		})

		$("#buyCheckBox").click(function() {
			var condition = $("#buyBtn").prop('disabled');
			$("#buyBtn").prop("disabled", condition ? false : true);
		})

		$("#userInfoUpdateBeBtn").click(function() {
			$("#userInfoNameSpan").hide();
			$("#userInfoTelSpan").hide();
			$("#userInfoNameInput").show();
			$("#userInfoTelInput").show();
			$("#userInfoUpdateBeBtn").hide();
			$("#userInfoUpdateAfBtn").show();
		})

		$("#userInfoUpdateAfBtn").click(function() {
			$("#userInfoNameSpan").show();
			$("#userInfoTelSpan").show();
			$("#userInfoNameInput").hide();
			$("#userInfoTelInput").hide();
			$("#userInfoUpdateBeBtn").show();
			$("#userInfoUpdateAfBtn").hide();
			// 수정 완료 버튼
			// update문 추가
		})

		$("#buyerInfoUpdateBeBtn").click(function() {

			$("#buyerInfoUpdateBeBtn").hide();
			$("#buyerInfoUpdateAfBtn").show();
			$("#buyerInfoNameSpan").hide();
			$("#buyerInfoTelSpan").hide();
			$("#buyerInfoNameInput").show();
			$("#buyerInfoTelInput").show();
			$("#buyerInfoAdrSpan").hide();
			$(".buyerInfoAdrInputDiv").show();
		})

		$("#buyerInfoUpdateAfBtn").click(function() {

			$("#buyerInfoUpdateBeBtn").show();
			$("#buyerInfoUpdateAfBtn").hide();
			$("#buyerInfoNameSpan").show();
			$("#buyerInfoTelSpan").show();
			$("#buyerInfoNameInput").hide();
			$("#buyerInfoTelInput").hide();
			$("#buyerInfoAdrSpan").show();
			$(".buyerInfoAdrInputDiv").hide();
			// 수정 완료 버튼
			// update문 추가
		})

	$("#buyerInfoUpdateAfBtn").hide();
	 $("#buyerInfoNameInput").hide();
	 $("#buyerInfoTelInput").hide();
	 $(".buyerInfoAdrInputDiv").hide();
	
	$(".paymentDivShow").click(function() {
		$(".paymentRadioDiv").show();
	})
	
	
	$(".paymentDivHide").click(function() {
		$(".paymentRadioDiv").hide();
	})
	
	$("#buyCheckBox").click(function() {
		 var condition = $("#buyBtn").prop( 'disabled' );
		 $("#buyBtn").prop("disabled", condition ? false : true);
	})
	
	
	$("#buyerInfoUpdateBeBtn").click(function() {

		 $("#buyerInfoUpdateBeBtn").hide();
		 $("#buyerInfoUpdateAfBtn").show();
		 $("#buyerInfoNameSpan").hide();
		 $("#buyerInfoTelSpan").hide();
		 $("#buyerInfoNameInput").show();
		 $("#buyerInfoTelInput").show();
		 $("#buyerInfoAdrSpan").hide();
		 $(".buyerInfoAdrInputDiv").show();
		 
		 
		 
	})
	
	$("#buyerInfoUpdateAfBtn").click(function() {
		
		
		 var deli_name = $("#buyerInfoNameInput").val();
		 var deli_phone = $("#buyerInfoTelInput").val();
		 var deli_zipcode = $("#sample6_postcode").val();
		 var deli_addr = $("#sample6_address").val();
		 var deli_detailaddr = $("#sample6_detailAddress").val();
		 

		 $("#buyerInfoUpdateBeBtn").show();
		 $("#buyerInfoUpdateAfBtn").hide();
		 
		 $("span#buyerInfoNameSpan").text(deli_name); 
		 $("#buyerInfoNameSpan").show();
		 
		 $("span#buyerInfoTelSpan").text(deli_phone); 
		 $("#buyerInfoTelSpan").show();
		 
		 $("#buyerInfoNameInput").hide();
		 $("#buyerInfoTelInput").hide();
		 
		 $("span#buyerInfoAdrSpan").text(deli_zipcode + " " + deli_addr + " " + deli_detailaddr); 
		 $("#buyerInfoAdrSpan").show();
		 $(".buyerInfoAdrInputDiv").hide();
		 // 수정 완료 버튼
		 
		
		 /*
		 기존 update문 
			$.ajax({  
				url:"mypage/deliUpdate",
				type:"put",
				contentType:'application/json;charset=utf-8',
				data:JSON.stringify({"deli_name":deli_name,"deli_phone":deli_phone,"deli_zipcode":deli_zipcode, "deli_addr":deli_addr, "deli_detailaddr":deli_detailaddr}), 
				success:function(){ 
					location.reload();
				},
				error:function(){
					alert("error");
				}
			});
		 */
		 
	})
	
})
</script>
</head>
<body>
  <jsp:include page="../include/header.jsp"/> 
  <input type="hidden" id="member_id" name="member_id" value="${mvo.member_id }">
<div class = "bodyDiv">
	<div class = "productInfoSubText">주문 상품 정보</div>  
	<div class = "productInfoBox">
		<div class = "productInfoImg">
		<img src="" class = "myInfoImg""/>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">주문자 정보</div>
		<div class="userInfoBox">
			<table class="userInfoTbl">
				<tr class="userInfoTr">
					<td class="userInfoTd">주문자 이름</td>
					<td class="userInfoTd"><span id="userInfoNameSpan">${mvo.memName }</span> <input type="text" class="form-control" id="userInfoNameInput" value=${mvo.memName }></td>
					<td align="right">
						<button type="button" class="btn btn-default" id="userInfoUpdateBeBtn">수정</button>
						<button type="button" class="btn btn-default" id="userInfoUpdateAfBtn">완료</button>
					</td>
				</tr>
				<tr class="userInfoTr">
					<td class="userInfoTd">전화번호</td>
					<td class="userInfoTd"><span id="userInfoTelSpan">${mvo.memEmail }</span> <input type="text" class="form-control" id="userInfoTelInput" value=${mvo.memEmail }></td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">배송 정보</div>
		<div class="userInfoBox">
			<table class="userInfoTbl" style="width: 800px;">
				<tr class="userInfoTr">
					<td style="width: 105px;">받는 사람</td>
					<td style="width: 105px;" class="userInfoTd"><span id="buyerInfoNameSpan">${mvo.memName }</span> <input type="text" class="form-control" id="buyerInfoNameInput" value=${mvo.memName }></td>
					<td align="right">
						<button type="button" class="btn btn-default" id="buyerInfoUpdateBeBtn">수정</button>
						<button type="button" class="btn btn-default" id="buyerInfoUpdateAfBtn">완료</button>
					</td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 105px;">전화번호</td>
					<td class="userInfoTd"><span id="buyerInfoTelSpan">${mvo.memEmail }</span> <input type="text" class="form-control" id="buyerInfoTelInput" value=${mvo.memEmail }></td>
				</tr>
				<tr class="userInfoTr">
					<td style="width: 105px;">주소</td>
					<td class="userInfoTd" style="width: 500px;"><span id="buyerInfoAdrSpan">서울특별시 서초구</span>
						<div class="buyerInfoAdrInputDiv">
							<br>
							<div class="buyerInfoAdrInputGroup">
								<input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호">
								<button onclick="sample6_execDaumPostcode()" class="btn">우편번호 찾기</button>
							</div>
							<input type="text" id="sample6_address" class="form-control" placeholder="주소">
							<input type="text" id="sample6_detailAddress" class="form-control" placeholder="상세주소">
							<input type="text" id="sample6_extraAddress" class="form-control" placeholder="참고항목">
						</div></td>
				</tr>
				<tr class="userInfoTr">
					<td class="userInfoTd" colspan="3">배송 메모</td>
				</tr>
				<tr class="userInfoTr">
					<td class="userInfoTd" colspan="3"><label for="memo" class="delMemoLabel"> <select class="form-control" id="memo" style="width: 700px;">
								<option>문앞에 놔 주세요</option>
								<option>벨 눌러주세요</option>
								<option>어쩌구</option>
								<option>저쩌구</option>
						</select>
					</label></td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">결제 금액</div>
		<div class="userInfoBox">
			<table class="userInfoTbl" style="width: 800px;">
				<tr class="userInfoTr">
					<td>상품 가격</td>
					<td style="text-align: right">13,000원</td>
				</tr>
				<tr class="userInfoTr">
					<td>할인</td>
					<td style="text-align: right">- 3,000원</td>
				</tr>
				<tr class="userInfoTr">
					<td>배송비</td>
					<td style="text-align: right">+ 2,500원</td>
				</tr>
				<tr class="userInfoTr">
					<td class="lastPayTextTd">총 결제 금액</td>
					<td class="lastPayTd">12,500원</td>
				</tr>
			</table>
		</div>
		<hr class="hrSec">
		<div class="userInfoSubText">결제 수단</div>
		<div class="userInfoBox">
			<div class="paymentRadioGroup">
				<label style="font-size: 18px;" class="paymentRadio"><input type="radio" name="optradio" class="paymentDivHide" id="cardpay" value="cardpay">&nbsp카드 결제</label> <label style="font-size: 18px;" class="paymentRadio"><input type="radio" name="optradio" class="paymentDivHide" id="passBookpay" value="passBookpay">&nbsp무통장 입금</label> <label style="font-size: 18px;" class="paymentRadio"><input type="radio" name="optradio" class="paymentDivHide" id="tosspay" value="tosspay">&nbsp토스페이</label> <label style="font-size: 18px;" class="paymentRadio"><input type="radio" name="optradio" class="paymentDivShow" id="giftCardpay" value="giftCardpay">&nbsp문화상품권</label>
			</div>
		</div>
		<div class="buyCheckbox">
			<label style="font-size: 16px;"><input type="checkbox" id="buyCheckBox">구매 정보 저장 및 결제 진행에 동의</label>
			<button type="button" class="btn" id="buyBtn" onclick="requestPay()">상품 결제</button>
		</div>
	</div>
	<hr class = "hrSec"> 
	<div class = "userInfoSubText">주문자 정보</div>
	<div class = "userInfoBox">
		<table class = "userInfoTbl">  
			<tr class = "userInfoTr"> 
				<td style = "width: 16px;" class = "userInfoTd">주문자 이름</td>
				<td class = "userInfoTd">
					<span id = "userInfoNameSpan">${mvo.name }</span>
				</td>
			</tr> 
			<tr class = "userInfoTr">  
				<td style = "width: 16px;" class = "userInfoTd">전화번호</td>
				<td class = "userInfoTd">  
					<span id = "userInfoTelSpan">${mvo.phone }</span>
				</td>
			</tr>
		</table>
	</div>
	<hr class = "hrSec">
	<div class = "userInfoSubText">배송 정보</div>
	<div class = "userInfoBox">
		<table class = "userInfoTbl" style = "width:800px;">
			<tr class = "userInfoTr">
				<td style = "width: 105px;">받는 사람</td>
				<td style = "width: 105px;" class = "userInfoTd">
				<span id = "buyerInfoNameSpan">${mvo.name }</span>
				<input type="text" class="form-control" id = "buyerInfoNameInput" value = "${mvo.name }">
				</td>
				<td align = "right">
					<button type="button" class="btn btn-default" id = "buyerInfoUpdateBeBtn">수정</button>
					<button type="button" class="btn btn-default" id = "buyerInfoUpdateAfBtn">완료</button>
				</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td style = "width:105px;">전화번호</td> 
				<td class = "userInfoTd">
				<span id = "buyerInfoTelSpan">${mvo.phone }</span>
				<input type="text" class="form-control" id = "buyerInfoTelInput" value = "${mvo.phone }">
				</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td style = "width: 105px;">주소</td>
				<td class = "userInfoTd" style = "width: 500px;">
					<span id = "buyerInfoAdrSpan">${mvo.zipcode } &nbsp ${mvo.addr } &nbsp ${mvo.detailaddr }</span>
					<div class = "buyerInfoAdrInputDiv">
						<br>
						<div class = "buyerInfoAdrInputGroup"><input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호" value = "${mvo.zipcode }">
						<button onclick="sample6_execDaumPostcode()" class="btn">우편번호 찾기</button>
						</div>
						<input type="text" id="sample6_address" class="form-control" placeholder="주소" value = "${mvo.addr }">
						<input type="text" id="sample6_detailAddress" class="form-control" placeholder="상세주소" value = "${mvo.detailaddr }">
						<input type="text" id="sample6_extraAddress" class="form-control" placeholder="참고항목"> 
					</div>
				</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td class = "userInfoTd" colspan = "3">배송 메모</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td class = "userInfoTd" colspan = "3"> 
				<label for="memo" class = "delMemoLabel">
					<select class="form-control" id="memo" style = "width: 700px;">  
					    <option value = "문앞에 놔 주세요">문앞에 놔 주세요</option>
					    <option value = "벨 눌러주세요">벨 눌러주세요</option>
					    <option value = "배송 전에 연락 주세요">배송 전에 연락 주세요</option>  
					    <option value = "경비실에 맡겨 주세요">경비실에 맡겨 주세요</option>
				 	</select>
				</label>
			  </td>
			</tr>
		</table>
	</div>
	<hr class = "hrSec">
	<div class = "userInfoSubText">결제 금액</div>
	<div class = "userInfoBox">
		<table class = "userInfoTbl" style = "width:800px;">
			<tr class = "userInfoTr">
				<td>상품 가격</td>
				<td style = "text-align:right"><fmt:formatNumber value="${moo.original_price }" pattern="#,##0" />원</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td>할인</td>
				<td style = "text-align:right">- <fmt:formatNumber value="${moo.original_price-moo.discount_price }" pattern="#,##0" />원</td>
			</tr>
			<tr class = "userInfoTr"> 
				<td>배송비</td>
				<td style = "text-align:right">+ 2,500원</td>
			</tr>

			<tr class = "userInfoTr"> 
				<td class = "lastPayTextTd">총 결제 금액</td>
				<td class = "lastPayTd"><fmt:formatNumber value="${moo.discount_price+2500}" pattern="#,##0" />원</td>
			</tr>
		</table>
	</div>
	<hr class = "hrSec">
	<div class = "userInfoSubText">결제 수단</div>
	<div class = "userInfoBox">
		<div class = "paymentRadioGroup">
			<label style = "font-size:18px;" class = "paymentRadio"><input type="radio" name="optradio" class = "paymentDivHide" id = "cardpay" value = "카드 결제">&nbsp카드 결제</label>
			<label style = "font-size:18px;" class = "paymentRadio"><input type="radio" name="optradio" class = "paymentDivHide" id = "passBookpay" value = "무통장 입금">&nbsp무통장 입금</label>
			<label style = "font-size:18px;" class = "paymentRadio"><input type="radio" name="optradio" class = "paymentDivHide" id = "tosspay" value = "토스페이">&nbsp토스페이</label>
			<label style = "font-size:18px;" class = "paymentRadio"><input type="radio" name="optradio" class = "paymentDivShow" id = "giftCardpay" value = "문화상품권">&nbsp문화상품권</label>
		</div>
	</div> 

	<div class="buyCheckbox"> 
  		<label style = "font-size:16px;"><input type="checkbox" id = "buyCheckBox">구매 정보 저장 및 결제 진행에 동의</label>
		<button type="button" class="btn" id = "buyBtn" onclick="requestPay()">상품 결제</button>
	</div>
</div>
</body>
</html>