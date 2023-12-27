<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function () {
	
	  var code = ""; // 인증번호를 저장할 변수

	    // 비밀번호 찾기 버튼 비활성화
	$(".findPwBtn").prop("disabled", true);
		
    $("#emailChk").click(function () {
        var email = $("#email").val();

        if (email === "") {
            alert("이메일을 입력하세요.");
            return;
        }

        $.ajax({
            type: "GET",
            url: "newPwmail?email=" + email,
            cache: false,
            success: function (data) {
                if (data === "error") {
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
                    code = data;
                }
            },
            error: function () {
                alert("서버와의 통신에 문제가 발생했습니다.");
            },
        });
    });
    

    // 인증 번호 확인 버튼 클릭 시
    $("#emailChk2").click(function(){
        if($("#email2").val() === code){
            $(".successEmailChk").text("인증번호가 일치합니다.");
            $(".successEmailChk").css("color","green");
            $("#emailDoubleChk").val("true");
            $("#email2").attr("disabled",true);
            $(".findPwBtn").prop("disabled", false);
        } else {
            $(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
            $(".successEmailChk").css("color","red");
            $("#emailDoubleChk").val("false");
            $("#email2").attr("autofocus",true);
            $(".findPwBtn").prop("disabled", true);
        }
    });
    $(".findPwBtn").click(function (event) {
        event.preventDefault(); // 폼의 기본 동작을 막음
        
        // findPwBtn 클릭 시 실행되는 나머지 코드
    });
});
</script>


<script>

$(document).ready(function () {
    $(".findPwBtn").click(function (event) {
        event.preventDefault(); // 폼의 기본 동작을 막음
        var member_id = $("#member_id").val();
        var email = $("#email").val();
		
        console.log(member_id);
        console.log(email);
        
        $.ajax({
            url: '${contextPath}/account/findMemberPw?member_id=' + member_id + '&email=' + email,
            type: "GET",
            success: function (result) {
            	console.log(result)
            	
                if (result === "success") {
                    // 아이디와 이메일이 일치할 경우 'newpassword.jsp'로 이동
                    window.location.href = "${contextPath}/account/newpassword?member_id=" + member_id;
                } else {
                    // 아이디와 이메일이 일치하지 않을 경우 오류 메시지 표시
                    alert('아이디와 이메일이 일치하지 않습니다.');
                }
            },
            error: function () {
                // 에러 상황 처리
                alert("아이디와 이메일 검증 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>









<style>
#passwordRelatedForm    {margin-top: 175px;
    margin-right: auto;
    margin-left: auto;
    padding: 40px; /* 여백을 크게 조정 */
    width: 90%; /* 전체 크기를 90%로 조정 */
    max-width: 600px; /* 최대 너비 설정 */
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
    
    }


  .form-group {
    margin-bottom: 20px;
  }

  .form-control {
    border-radius: 20px;
    border: 1px solid #ccc;
    padding: 10px;
    width: calc(100%);
  }

  .form-control:focus {
    outline: none;
  }

  .input-group-btn {
    display: flex;
    align-items: center;
  }

  .btn-primary {
    border-radius: 20px;
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
  }

  .btn-primary:hover {
    background-color: #0056b3;
  }

  .successEmailChk {
    color: green;
    font-style: italic;
    margin-top: 5px;
    display: block;
  }

  input[type="text"]:disabled {
    background-color: #f2f2f2;
  }

  .findPwBtn {
    border-radius: 20px;
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    display: block;
    width: calc(100%);
    margin-top: 10px;
  }

  .findPwBtn:hover {
    background-color: #0056b3;
  }
  h3 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}
label {
    font-weight: bold;
    font-size: 18px; /* 라벨 폰트 크기 키우기 */
}

</style>
</head>
<body>
	<jsp:include page="../include/header.jsp" />



<div class="container">

    <div class="row">
            <div class="mt-3" id="passwordRelatedForm" style="display: block;">
    <h3>비밀번호 찾기</h3>
        <div class="form-group">
            <label for="member_id">아이디</label>
            <input id="member_id" name="member_id" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요." />
        </div>
        <div class="email-group">
            <label for="email">이메일</label>
            <div class="input-group">
                <input id="email" type="text" name="email" title="이메일 주소를 입력해주세요." required class="form-control" placeholder="이메일 주소를 입력하세요." />
                <span class="input-group-btn">
                    <span id="emailChk" class="btn btn-primary">인증번호 보내기</span>
                </span>
            </div>
            <div>
                <input id="email2" type="text" name="email2" title="인증번호 입력" disabled required class="form-control" placeholder="인증번호를 입력하세요." />
                <span id="emailChk2" class="btn btn-primary">이메일인증</span>
            </div>
            <span class="point successEmailChk">이메일 입력 후 인증번호 보내기를 해주십시오.</span>
            <input type="hidden" id="emailDoubleChk" />
        </div>
        <button type="submit" class="btn btn-primary mt-2 findPwBtn">비밀번호 재설정 </button>
    </form>
</div>
</body>
</html>