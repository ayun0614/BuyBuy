<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
.sticky-container {
	position: fixed;
	bottom: 40px;
	right: 30px;
	z-index: 1000;
}

.sticky-button {
	border: none;
	background-color: rgba(255,255,255,0);
	cursor: pointer;
}

#chat-box {
	visibility: hidden;
	display: flex;
	flex-direction: column-reverse;
	position: fixed;
	bottom: 110px;
	right: 35px;
	width: 300px;
	height: 450px;
	border: 1px solid #ccc;
	border-radius: 20px;
	background-color: #ffffff;
	z-index: 1001;
	box-shadow: 1px 1px 1px 1px gray;
}

#chatMain {
	text-align: center;
	margin-bottom: 400px;
	width: 300px;
	position: fixed;
	font-size: 25px;
	padding: 2px;
}

#maincontent {
	text-align: center;
	margin-bottom: 350px;
	width: 300px;
	position: fixed;
	font-size: 25px;
	padding: 2px;
}

.answer {
	display: none;
	padding: 10px;
	width:180px;
	margin: 5px;
	margin-right: auto;
	background-color: #F3F5F8;
	color: black;
	border: none;
	border-radius: 10px;
}

.mainchattext {
	
	padding: 10px;
	width:185px;
	margin: 5px;
	margin-right: auto;
	background-color: #F3F5F8;
	color: black;
	border: none;
	border-radius: 10px;
}

.question {
	text-align:left;
	padding: 10px;
	margin: 5px;
	width: 220px;
	margin-left: auto;
	background-color: black;
	color: white;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.question:hover {
	background-color: #DFE9FF;
	color: black;
}

.resetAll {
	padding: 10px;
	margin: 5px;
	width: 150px;
	margin-left: auto;
	background-color: black;
	color: white;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.resetAll:hover {
	background-color: #DFE9FF;
	color: black;
}
.answertitle{
	display: flex;
}
.mainchat{
	display: flex;
}
</style>
<script>
	$(document).ready(function() {

		$("#showChatBtn").click(function() {
			$("#resetAll").hide();
			$("#chat-box").css("visibility", function(i, visibility) {
				return (visibility === "visible") ? "hidden" : "visible";
			});

			var currentImage = $("#showChatBtn img").attr("src");
			var newImage = (currentImage.toLowerCase().includes("chat.png")) ? "${contextPath}/resources/image/cancel.png" : "${contextPath}/resources/image/chat.png";
			$("#showChatBtn img").attr("src", newImage);

			$(".answer").hide();
			$(".resetAll").hide();
			$(".answerimg1").hide();
			$(".answerimg2").hide();
			$(".answerimg3").hide();
			$(".answerimg4").hide();
			$(".question").show();
			$(".mainchat").show();

		});

		$(".resetAll").click(function() {
			$(".answer").hide();
			$(".resetAll").hide();
			$(".answerimg1").hide();
			$(".answerimg2").hide();
			$(".answerimg3").hide();
			$(".answerimg4").hide();
			$(".mainchat").show();
			$("#question1").show();
			$("#question2").show();
			$("#question3").show();
			$("#question4").show();
			
		});

	});
	function showAnswer() {
		var answer = document.querySelector('#answer1');
		var img = document.querySelector('.answerimg1');
		answer.style.display = 'block';
		img.style.display = 'block';
		$("#question2").hide();
		$("#question3").hide();
		$("#question4").hide();
		$(".mainchat").hide();
		$("#resetAll").show();
	}
	function showAnswer2() {
		var answer = document.querySelector('#answer2');
		var img = document.querySelector('.answerimg2');
		answer.style.display = 'block';
		img.style.display = 'block';
		$("#question1").hide();
		$("#question3").hide();
		$("#question4").hide();
		$(".mainchat").hide();
		$("#resetAll").show();

	}
	function showAnswer3() {
		var answer = document.querySelector('#answer3');
		var img = document.querySelector('.answerimg3');
		answer.style.display = 'block';
		img.style.display = 'block';
		$("#question1").hide();
		$("#question2").hide();
		$("#question4").hide();
		$(".mainchat").hide();
		$("#resetAll").show();
	}
	function showAnswer4() {
		var answer = document.querySelector('#answer4');
		var img = document.querySelector('.answerimg4');
		answer.style.display = 'block';
		img.style.display = 'block';		
		$("#question1").hide();
		$("#question2").hide();
		$("#question3").hide();
		$(".mainchat").hide();
		$("#resetAll").show();
	}
</script>
<body>
	<div class="sticky-container">
		<button class="sticky-button" id="showChatBtn">
			<img src="${contextPath}/resources/image/chat.png" alt="버튼 이미지">
		</button>
	</div>
	<div id="chat-box">
		<div id="chatMain">BUY BUY</div>
		<button class="resetAll" id="resetAll">
			<span>처음으로 돌아가기 </span>
		</button>
		<div class="answertitle">
			<div class="answerimg1" style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin:3px; display:none;"><img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2023/02/urban-20230228144115810458.jpg" style="width: 100%; height: 100%; object-fit: cover;"></div>		
			<div class="answer" id="answer1">
			<span>비회원으로는 구매 신청이 불가능합니다.<br>간편회원가입을 이용하여 빠르게 가입 후 신청이 가능합니다.</span>
		</div>
		</div>

		<button class="question" id="question1" onclick="showAnswer()">
			<span class="content-box">비회원으로 구매 신청을 할 수 있나요?  </span>
		</button>
		<div class="answertitle">
			<div class="answerimg2" style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin:3px; display:none;"><img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2023/02/urban-20230228144115810458.jpg" style="width: 100%; height: 100%; object-fit: cover;"></div>		
			<div class="answer" id="answer2">
				<span>네. 마이페이지에서 취소 신청이 가능합니다.</span>
		</div>
		</div>

		<button class="question" id="question2" onclick="showAnswer2()">
			<span class="content-box">배송 전 취소가 가능한가요? </span>
		</button>

		<div class="answertitle">
			<div class="answerimg3" style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin:3px; display:none;"><img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2023/02/urban-20230228144115810458.jpg" style="width: 100%; height: 100%; object-fit: cover;"></div>
			<div class="answer" id="answer3">
				<span>마이페이지에서 등록한 게시물의 상품 이미지를 누르면 총 구매 수량을 알 수 있습니다.</span>
			</div>
		</div>

		<button class="question" id="question3" onclick="showAnswer3()">
			<span class="content-box">등록한 게시물의 주문 수량은 어디서 볼 수 있나요? </span>
		</button>
		
		
		<div class="answertitle">
			<div class="answerimg4" style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin:3px; display:none;"><img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2023/02/urban-20230228144115810458.jpg" style="width: 100%; height: 100%; object-fit: cover;"></div>
			<div class="answer" id="answer4">
				<span>마이페이지에서 신청이 가능하고, 관리자가 승인 후 게시글 작성이 가능합니다.</span>
			</div>
		</div>

		<button class="question" id="question4" onclick="showAnswer4()">
			<span class="content-box">판매자 계정 신청은 어디서 하나요? </span>
		</button>
		
		<div class="mainchat">
			<div class="answerimg5" style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden; margin:3px;"><img src="https://www.urbanbrush.net/web/wp-content/uploads/edd/2023/02/urban-20230228144115810458.jpg" style="width: 100%; height: 100%; object-fit: cover;"></div>
			<div class="mainchattext" id="mainchattext">
				<span>안녕하세요 buybuy 입니다. <br> 무엇을 도와드릴까요? </span>
			</div>
		</div>
	</div>
</body>
</html>