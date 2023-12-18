<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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
  	background-color:white;
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
        border-radius:20px;
        background-color: #ffffff;
        z-index: 1001; 
        box-shadow:1px 1px 1px 1px gray;
       
    }
    
    #chatMain {
            text-align: center;
            margin-bottom:400px;
            width: 300px;
            position:fixed;
            font-size: 25px;
            padding: 2px;
        }
    #maincontent {
       text-align: center;
       margin-bottom:350px;
       width: 300px;
       position:fixed;
       font-size: 25px;
       padding: 2px;
   }
        
    .answer {
            display:none;
            padding:10px;
            margin:5px;
            margin-right:auto;
            background-color:#F3F5F8;
            color:black;
            border:none;
            border-radius:10px;
            
        }

        .question {
            padding: 10px;
            margin:5px;
            width:150px;
            margin-left: auto;
            background-color: black;
            color: white;
            border:none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .question:hover {
    	background-color: #DFE9FF; 
    	color:black;
		}
		
		 .resetAll {
            padding: 10px;
            margin:5px;
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
            color:black;
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
        var newImage = (currentImage.toLowerCase().includes("chat.png")) 
            ? "${contextPath}/resources/image/cancel.png" 
            : "${contextPath}/resources/image/chat.png";
        $("#showChatBtn img").attr("src", newImage);
        
     
        $(".answer").hide();
        $(".resetAll").hide();
        $(".question").show();
        
    });
    
    
    $(".resetAll").click(function() {
    	$(".answer").hide();
    	$(".resetAll").hide();
    	$("#question1").show();
    	$("#question2").show();
    	$("#question3").show();
    	$("#question4").show();
    });
    
   
});
function showAnswer() {
    var answer = document.querySelector('#answer1');
    answer.style.display = 'block';
    $("#question2").hide();
    $("#question3").hide();
    $("#question4").hide();
    $("#resetAll").show();
}
function showAnswer2() {
    var answer = document.querySelector('#answer2');
    answer.style.display = 'block';
    $("#question1").hide();
    $("#question3").hide();
    $("#question4").hide();
    $("#resetAll").show();
    
}
function showAnswer3() {
    var answer = document.querySelector('#answer3');
    answer.style.display = 'block';
    $("#question1").hide();
    $("#question2").hide();
    $("#question4").hide();
    $("#resetAll").show();
}
function showAnswer4() {
    var answer = document.querySelector('#answer4');
    answer.style.display = 'block';
    $("#question1").hide();
    $("#question2").hide();
    $("#question3").hide();
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
    	<div id="maincontent">buybuy 방문을 환영합니다</div>
        <button class="resetAll" id="resetAll">
        	<span>처음으로 돌아가기 </span>
        </button>
 		
        <div class="answer" id="answer1"> 
        	<span> 라면</span>
        </div>
        
        <button class="question" id="question1" onclick="showAnswer()">
        	<span class="content-box">오늘 점심은?</span>
        </button>
        
        <div class="answer" id="answer2"> 
        	<span>피곤함</span>
        </div>
        
        <button class="question" id="question2" onclick="showAnswer2()">
        	<span class="content-box">지금의상태는?</span>
        </button>
        
        <div class="answer" id="answer3"> 
        	<span>답변3</span>
        </div>
        
        <button class="question" id="question3" onclick="showAnswer3()">
        	<span class="content-box">질문3?</span>
        </button>
        
        <div class="answer" id="answer4"> 
        	<span>답변4</span>
        </div>
        
        <button class="question" id="question4" onclick="showAnswer4()">
        	<span class="content-box">질문4?</span>
        </button>
        
        
        
        
        
        
        
       
    </div>
</body>
</html>