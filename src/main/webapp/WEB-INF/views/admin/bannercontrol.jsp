<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시글 관리</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
		.line {
		    margin: 0 auto; 
		    width: 80%; 
		    margin-top: 0px;
		    border-top: 1px solid #E2E2E2;
		}
	    .container-fluid {
		   	margin-top: 20px;
		    text-align: center;
		    padding: 0px; 
		    border-radius: 5px;	       	
	    }
	    .head {
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        padding: 10px;
	        color: #007bff;
	        cursor: pointer;
	        margin-bottom: 10px;
        }
        .backleft {
	        margin-left: 200px; 
	        color: #000;
	        font-size: 24px;
        }
        .title {
	        display: flex;
	        align-items: center;
	        margin: 0 auto;
        }
        .title1 {
	        text-align: center;
	        font-size: 40px;
	        font-weight: bold;
	        margin-left: -200px;
	        color: #000;
	        margin-bottom: 10px;     
        }
        .container-fluid {
        	text-align: center;
        }
        h1 {
	        border-bottom: 2px solid #E2E2E2;
	        padding-bottom: 20px;
	        margin-bottom: 20px;
        }
        .banner {
   	 		border: 1px solid gray;
		}
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
<div class="name">
    <div class="headhead">
        <div class="head">
            <div class="left" onclick="location.href='${contextPath }/admin'">
                <i class="glyphicon glyphicon-chevron-left backleft"></i>
            </div>
            <div class="title">
                <span class="title1">배너 관리</span>
            </div>
        </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="container-fluid"> 
    	 <form action="#" class="banner" method="post">
    	 	<label for="password">비밀번호:</label>
        	<input type="password" id="password" name="password" required>
        <button type="submit">제출</button>
    	 </form>
    </div>

</body>
</html>