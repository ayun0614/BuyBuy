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
		   	margin-top: 20px;
		    border-radius: 0px;	 
		    border: 2px solid #E2E2E2;
		    max-width:80%;
		    height: 100vh;
		    font-size: 18px;
		    position: relative;
	    }
        .icon-container {
		    background-color: #537FE7;
		    border-radius: 50%;
		    padding: 15px; 
		    position: absolute; 
		    top: 240px;
		    left: 160px; 
			}
		.bi-file-earmark-image {
		    font-size: 2em; 
		    color: white; 
		}
		#upload .bi-file-plus {
    		font-size: 10em;
    		max-width:100px; 
    		color: #E2E2E2;
		}
		#upload {
			justify-content: center;
		    width: 550px;
		    margin: 100px;
		    margin-left: 100px; 
		    margin-bottom:0px;
		    padding: 10px; 
		    border: 2px solid #E2E2E2;
		    border-radius: 10px;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		}
		
		
		.sub{
		position: absolute;
        top: 100px;
        right: 150px;
			
		}
		.sub input,
		.sub div {
		    font-size: 1em; 
		    width: 100%; 
		    box-sizing: border-box;
		    margin-bottom: 20px; 
		}
	    .preview-container {
	        display: flex;
	        overflow-x: auto;
	        white-space: nowrap;
	    }
	
	    .preview {
	        display: inline-block;
	        margin: 30px;
	        margin-right: 20px; 
	    }
</style>
<script>
    function validateForm() {
        var title = document.getElementById('title').value;
        var content = document.getElementById('content').value;
        var url = document.getElementById('url').value;
        var fileInput = document.querySelector('input[type="file"]');

        if (title.trim() === '' || content.trim() === '' || url.trim() === '' || !fileInput.files.length) {
            alert('모든 필드를 작성하고 이미지를 선택하세요.');
            return false; 
        }

        return true;
    }
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"/>
	
 <div class="name">
        <div class="headhead">
            <div class="head">
                <div class="left" onclick="location.href='${contextPath }/admin/admin'">
                    <i class="glyphicon glyphicon-chevron-left backleft"></i>
                </div>
                <div class="title">
                    <span class="title1">배너 관리</span>
                </div>
            </div>
        </div>
    </div>
    
    <div class="line"></div>
     <div class="d-flex align-items-center justify-content-center icon-container">
            <i class="bi bi-file-earmark-image bi-file-earmark-image"></i>
        </div>
    <div class="container-fluid"> 
       
        
        <form action="${contextPath}/admin/insertBannerImg" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div id="upload">
                <div id="pic">사진 업로드</div>
                <div><i class="bi bi-file-plus"></div></i>
                <div><input type="file" name="image_url" multiple style="margin-bottom: 6px;"/></div>
            </div>
            
            <div id="sub" class="sub">
                
                    <div>제목</div>
                    <input id="title" type="text" name="banner_name">
                    <div>내용</div>
                    <input id="content" type="text" name="banner_text">
                    <div>연결될 url</div>
                    <input id="url" type="text" name="banner_url">
                	<input type="submit" class="btn btn-primary btn-sm pull-right"  value="등록하기" />
            </div> 
             </form>
             <div class="preview-container">
    <c:forEach items="${bo}" var="bo" varStatus="loop">
        <div class="preview" data-url="${bo.image_url}">
            <div class="banner1" style="position: relative; width:200px;">
                <img src="${bo.image_url}" style="width: 180px; height: 180px; object-fit: contain;">
                <button class="bi bi-x-circle" onclick="deleteBanner('${bo.image_url}')" style="position: absolute; top: 0; right: 0; border: none; background:none;"></button>
            </div>
        </div>
    </c:forEach>
</div>

<script>


function deleteBanner(image_url){
	$.ajax({
		url:"${contextPath}/admin/deleteBanner?image_url="+image_url,
		type:"DELETE",
		success:function(){
			alert("삭제되었습니다");
			location.reload();
		},
		error:function(){
			alert("삭제실패");
		}
			
	});
}

</script>

       
    </div>
</body>
</html>