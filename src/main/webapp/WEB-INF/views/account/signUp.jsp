<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>BuyBuy</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/signUp.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if (${ !empty msgType }) {
		$("#messageType").attr("class", "modal-content panel-warning");
		$("#myMessage").modal("show");
	}

	if(${!empty mem}){
		$("#registerButton").attr("disabled", false);
	}else{
		$("#registerButton").attr("disabled", true);
	}
	
	
	// 이메일 보내기 버튼 클릭 시
	$("#emailChk").click(function() {
		var email = $("#email").val();
	
		if (email === "") {
			alert("이메일을 입력하세요.");
			return;
		}

		$.ajax({
			type: "GET",
			url: "mailCheck?email=" + email,
			cache: false,
			success: function(data) {
				if (data === "using_email") {
					alert("이미 사용중인 이메일 입니다. 다른 이메일 주소를 입력해주세요.");
					$("#email").attr("autofocus", true);
					$(".successEmailChk").text("다른 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color", "red");
				}
				else if (data == "error") {
					alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
					$("#email").attr("autofocus", true);
					$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color", "red");
				} else {
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
					$("#email2").attr("disabled", false);
					$("#emailChk2").css("display", "inline-block");
					$(".successEmailChk").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
					$(".successEmailChk").css("color", "green");
					code = data; // 이 부분이 전역 변수로 선언되어야 함을 전제로 작성된 부분입니다.     
				}
			}
		});
	});

	// 인증 번호 확인 버튼 클릭 시
	$("#emailChk2").click(function() {
		if ($("#email2").val() === code) {
			$(".successEmailChk").text("인증번호가 일치합니다.");
			$(".successEmailChk").css("color", "green");
			$("#emailDoubleChk").val("true");
			$("#email2").attr("disabled", true);
			$("#registerButton").attr("disabled", false);
		} else {
			$(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
			$(".successEmailChk").css("color", "red");
			$("#emailDoubleChk").val("false");
			$("#email2").attr("autofocus", true);
			$("#registerButton").attr("disabled", true);
		}
	});
});
	function findPostcode() {
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
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname))  {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("extraAddress").value = extraAddr;
	
				} else {
					document.getElementById("extraAddress").value = '';
				}
	
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailaddr").focus();
			}
		}).open();
	}
	
	function registerCheck() {
		var member_id = $("#member_id").val();
	
		// Check if member_id field is empty
		if (member_id === "") {
			$("#checkMessage").html("아이디를 입력하세요."); // 입력 필드가 비어 있을 때 메시지 출력
			$("#myModal").modal("show");
			return; // 더 이상 진행하지 않고 함수를 종료
		}
	
		$.ajax({
			url: "registerCheck",
			type: "get",
			data: { "member_id": member_id },
			success: function(result) {
				if(result == 1) { $("#checkMessage").html("사용할 수 있는 아이디입니다."); } 
				else { $("#checkMessage").html("이미 사용중인 아이디입니다."); }
				$("#myModal").modal("show");
		},
			error: function() {
				alert("error");
			}
		});
	}

	function passwordCheck() {
		var memPass1 = $("#password").val();
		var memPass2 = $("#password2").val();
	
		if (memPass1 !== memPass2) {
			$("#passMessage").html("비밀번호가 일치하지 않습니다. 다시 입력해주세요."); // 일치하지 않을 때 메시지 수정
		} else {
			$("#passMessage").html("");
			$("#memPassword").val(memPass1);
		}
	}

	function validateForm() {
		var name = document.getElementById("name").value;
		var member_id = document.getElementById("member_id").value;
		var password = document.getElementById("password").value;
		var password2 = document.getElementById("password2").value;
		var phone = document.getElementById("phone").value;
		var email = document.getElementById("email").value; // 이메일 값 추가
		var postcode = document.getElementById("postcode").value;
		var address = document.getElementById("address").value;
		var detailaddr = document.getElementById("detailaddr").value;
	
		if (name === "" || member_id === "" || password === "" || password2 === "" || phone === "" || email === "" || postcode === "" || address === "" || detailaddr === "") {
			alert("모든 필수 항목을 작성해주세요.");
			return false; // 회원가입 제한
		}
		if (password !== password2) {
			alert("비밀번호가 일치하지 않습니다");
			return false;
	
			if (errorMessage.includes("인증번호가 일치하지 않습니다.")) {
				alert("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
				return false; // 회원가입 제한
			}
			return true; // 폼 제출 허용
		}
	
		var emailRegex = /\S+@\S+\.\S+/;
		if (!emailRegex.test(email)) {
			alert("올바른 이메일 주소를 입력해주세요.");
			return false; // 회원가입 제한
		}
	
		return true; // 폼 제출 허용
	}

	function autoHyphen2(target) {
		target.value = target.value
			.replace(/[^0-9]/g, '')
			.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3")
			.replace(/(\-{1,2})$/g, "");
	}
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<div class="container">
		<form action="${contextPath }/account/insert" method="post" onsubmit="return validateForm()">
			<div class="panel panel-default">
				<div class="panel-heading">회원가입</div>
				<div class="panel-body">
					<c:if test="${!empty mem}">
						<input id="profileimg" name="profileimg" type="hidden" value="${mem.profileimg }" />
					</c:if>
					<c:if test="${empty mem}">
						<div class="form-group">
							<label for="name">이름</label>
							<input id="name" name="name" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요." onkeyup="nameCheck ()" />
						</div>
					</c:if>
					<c:if test="${!empty mem}">
						<input id="name" name="name" type="hidden" value="${mem.name }" />
					</c:if>
					<c:if test="${empty mem}">
						<div class="form-group">
							<label for="member_id">아이디</label>
							<div class="input-group">
								<!-- Bootstrap input group 사용 -->
								<input id="member_id" name="member_id" class="form-control" maxlength="20" placeholder="아이디를 입력하세요.">
								<span class="input-group-btn">
									<button type="button" class="btn btn-primary" onclick="registerCheck()">중복확인</button>
								</span>
							</div>
						</div>
					</c:if>
					<c:if test="${!empty mem}">
						<input id="member_id" name="member_id" type="hidden" value="${mem.member_id }" />
					</c:if>
					<c:if test="${empty mem}">
						<div class="form-group">
							<label for="password">비밀번호 </label>
							<input id="password" name="password" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요." />
							<span>
								<!-- 아이콘 추가 -->
							</span>
						</div>
						<div class="form-group">
							<label for="password2">비밀번호 확인</label>
							<input id="password2" name="password2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요." />
							<span id="passMessage" style="color: red"></span>
						</div>
					</c:if>
					<c:if test="${!empty mem}">
						<input id="password" name="password" type="hidden" value="${mem.password }" />
						<input id="password2" name="password2" type="hidden" value="${mem.password }" />
					</c:if>
					<div class="form-group">
						<label for="phone">전화번호</label>
						<input id="phone" name="phone" type="text" class="form-control" oninput="autoHyphen2(this)" maxlength="13" placeholder="전화번호를 입력하세요" value="${mem.phone }">
					</div>
					<c:if test="${empty mem}">
						<tr class="email">
							<th><label for="useremail">이메일</label></th>
							<td>
								<div class="input-group">
									<input id="email" type="text" name="email" title="이메일 주소를 입력해주세요." required class="form-control " placeholder="이메일 주소를 입력하세요." />
									<span class="input-group-btn">
										<span id="emailChk" class="btn btn-primary">인증번호 보내기</span>
									</span>
								</div>
								<div class="input-group">
									<input id="email2" type="text" name="email2" title="인증번호 입력" disabled required class="form-control" placeholder="인증번호를 입력하세요." />
									<span class="input-group-btn">
										<span id="emailChk2" class="btn btn-primary">이메일인증</span>
									</span>
								</div> <span class="point successEmailChk">이메일 입력 후 인증번호 보내기를 해주십시오.</span> <input type="hidden" id="emailDoubleChk" />
								<p class="tip">아이디 비밀번호 분실 시 필요한 정보이므로, 정확하게 기입해 주십시오.</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${!empty mem}">
						<input type="hidden" id="emailDoubleChk" value="true" />
						<input id="email" type="hidden" name="email" value="${mem.email }" />
					</c:if>
					<div class="form-group">
						<label for="address">주소</label>
						<div class="input-group">
							<!-- Bootstrap input-group 사용 -->
							<input type="text" id="postcode" class="form-control" name="zipcode" placeholder="우편번호">
							<span class="input-group-btn">
								<button class="btn btn-primary" type="button" onclick="findPostcode()">주소찾기</button>
							</span>
						</div>
					</div>
					<div class="form-group">
						<div class="address-field">
							<input type="text" id="address" name="addr" class="form-control" placeholder="주소">
						</div>
						<div class="address-field">
							<input type="text" id="detailaddr" name="detailaddr" class="form-control" placeholder="상세주소">
						</div>
						<div class="address-field">
							<input type="hidden" id="extraAddress" name="addr" class="form-control" placeholder="참고항목">
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<tr height="50">
					<div style="width: 1100px; margin: 0 auto;">
						<input id="registerButton" type="submit" maxlength="20" value="회원가입" class="btn btn-primary btn-block">
					</div>
			</div>
		</form>
		<!--  다이얼로그창(모달) -->
		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<p id="checkMessage"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 실패 메세지를 출력(modal) -->
		<div id="myMessage" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div id="messageType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">${msgType}</h4>
					</div>
					<div class="modal-body">
						<p>${msg}</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
