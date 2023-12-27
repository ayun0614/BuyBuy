<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시글 관리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
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
	    	display:flex;
		   	margin-top: 20px;
		    text-align: center;
		    border-radius: 0px;	 
		    border: 2px solid #E2E2E2;
		    max-width:80%;
		    height: 100vh;
		    font-size: 18px;      	
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
		
		.icon-container {
		    background-color: #537FE7;
		    border-radius: 50%;
		    padding: 15px; 
		    position: absolute; 
		    top: 270px;
		    left: 170px; 
			}
		
		.bi-file-earmark-image {
		    font-size: 2em; 
		    color: white; 
		}
        h1 {
	        border-bottom: 2px solid #E2E2E2;
	        padding-bottom: 20px;
	        margin-bottom: 20px;
        }
        .banner {
   	 		border: 1px solid gray;
		}
		 #upload {
		 	margin-top: 120px;
		    margin-left: 70px;
		    align-items: center;
		    justify-content: flex-start;
		    margin-bottom: 10px;
		    width: 150px;
            
        }
        #up {
		    width: 300px;
		    height: 300px; 
		    border: 2px solid #E2E2E2; 
		}

        #pic {
            margin-right: 10px;
            font-weight: bold;
        
        }

        #input {
        	margin-top:80px;
            margin-left:700px;
        }
        #preview {
        	display:flex;
        	margin-top: 380px;
        }
        #upload .bi-file-plus {
    		font-size: 10em;
    		max-width:100px; 
    		color: #E2E2E2;
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
    <form action="${contextPath}/insertBannerImg" method="post" enctype="multipart/form-data">
	     <div class="d-flex align-items-center justify-content-center icon-container">
	        <i class="bi bi-file-earmark-image bi-file-earmark-image"></i>
	     </div>
	     <div id="upload">
	     <div id="pic">사진 업로드</div>
	     
	     
	      <div>
                     <i class="bi bi-file-plus"></i><input type="file" name="image_url" multiple
                        style="margin-bottom: 6px;"/>
                  </div>
	     
	     
	    <!--   <button id="up">
	     <i class="bi bi-file-plus"></i>
	     </button>-->
	     </div>
	     <div id="preview">
	     <div><i class="bi bi-x-circle"></i></div>
	     <div><i class="bi bi-x-circle"></i></div>
	     <div><i class="bi bi-x-circle"></i></div>
	     </div>
	     <div id="input">
	     <div>제목</div>
	     <input id="title" type="text" name="banner_name">
	     <div>내용</div>
	     <input id="content" type="text" name="banner_text">
	     <div>연결될 url</div>
	     <input id="url" type="text" name="banner_url">
	     </div>
	     
	        <input type="submit" class="btn btn-primary btn-sm pull-right"
                           style="margin-right: 10px;" value="등록하기" />
	     <div>
    ${message}
</div>
	     
	     
  
    </form>
  </div>
</body>
</html>