<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시글 관리</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 <script type="text/javascript">
        $(document).ready(function () {
            waitList();
            alert("aab");
        });

        function waitList() {
            alert("aa");
            $.ajax({
                url: "${contextPath}/admin/all",
                 type: "get",
                dataType: "json",
                 success: createView,
                 error: function () {
                     alert("error");
                }
             });
        }

        function createView(data) {
            var list = "<table class='admin_board_wrap' id='user-admin'>";
            list += "<thead class='admin_boardList'>"; 
            list += "<th class='admin_board_head'>판매자 아이디</th>"; 
            list += "<th class='admin_board_head'>상품 ID</th>"; 
            list += "<th class='admin_board_head'>등록된 게시글</th>"; 
            list += "<th class='admin_board_head'>카테고리</th>"; 
            list += "<th class='admin_board_head'>작성일자</th>";
            list += "<th class='admin_board_head'>삭제</th>"; 
            list += "</thead>";
            list += "<tbody id='user-admin-body1'>";
            $.each(data, function (index, obj) {
                list += "<tr>";
                list += "<td>" + obj.memID + "</td>";
                list += "<td>" + obj.productIdx + "</td>";
                list += "<td>" + obj.productName + "</td>";
                list += "<td>" + obj.category + "</td>";
                list += "<td>" + obj.startDate + "</td>";
                list += "<td><button class='custom-button' onclick='fDelete(" + obj.idx + ")'><i class='glyphicon glyphicon-remove'></i></button></td>"; // 이중 따옴표 수정
                list += "</tr>";
            });
            list += "</tbody>";
            list += "</table>";

            $("#member_list").html(list);
        }

        function fDelete(data) {
            alert("meow");
        }
</script>
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
        .search-bar {
        	display: flex;
        	align-items: center;
        	justify-content: center; 
        	margin-left: -720px;
        	margin-bottom: 20px;
    	}
    	.search-bar-content {
        	display: flex;
        	justify-content: space-around;
        	justify-content: flex-start;
        	margin-left: auto;
        	margin-right: auto;
    	}
    	.category-select,
    	.search-input,
    	.search-button {
        	margin-right: 8px; 
        	height: 50px;
    	}
    	.admin_board_wrap {
        	width: 90%; 
        	margin-top: 20px;
        	margin-left: auto;
        	margin-right: auto;
        	text-align: center;
    	}
    	.search-input {
	        flex-grow: 1;
	        padding: 8px 25px;
	        border: 1px solid #E2E2E2;
	        max-width: 100%; 
	        border-radius: 0px;
	        margin-right: 8px;
    	}
    	.category-select,
    	.category-select1 {
	        flex-shrink: 0;
	        padding: 8px;
	        border: 1px solid #E2E2E2;
	        border-radius: 0px;
	        margin-right: 8px;
	    	width: auto; 
    	}
    	.search-button {
	        background-color: #537FE7;
	        color: #fff;
	        border: none;
	        padding: 8px 12px;
	        border-radius: 0px;
	        cursor: pointer;
    	}
        table {
	        border-collapse: collapse;
	        width: 80%; 
	        margin-top: 20px;
	        margin-left: auto; 
	        margin-right: auto; 
	        text-align: center; 
        }
        th, td {
	        border: 1px solid #dddddd;
	        text-align: center;
	        font-size: 15px;
	        padding: 8px;
        }
        th {
	        background-color: #f2f2f2;
	        text-align: center; 
        }
        .search-input {
	        flex-grow: 1;
	        padding: 8px 25px; 
	        border: 1px solid #E2E2E2;
	        max-width: 80%;
	        border-radius: 0px;
	        margin-right: 8px;
        }
        .category-select,
        .category-select1 {
	        flex-shrink: 0;
	        padding: 8px;
	        border: 1px solid #E2E2E2;
	        border-radius: 0px;
	        margin-right: 8px;
	        width: auto; 
        }
        td select {
        	max-width: 80%; 
        }
        .admin_board_wrap {
		    width: 95%; 
		    margin-top: 40px; 
		    margin-bottom: 40px;
		    margin-left: auto;
		    margin-right: auto;
		    text-align: center;
	    }
        .admin_board_head {
        	padding: 8px; 
        }
        .custom-button {
			background-color: red;
			padding: 2px 3px auto;
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
                <span class="title1">게시글 관리</span>
            </div>
        </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="container-fluid">              
     <div class="search-bar">
     <div class="search-bar-content">
		<select id="categorySelect" class="category-select">
			  <option value="all">전체 </option>
			  <option value="category1">카테고리 1</option>
			  <option value="category2">카테고리 2</option>
			  <option value="category3">카테고리 3</option> 
		</select>
	<input id="searchInput" type="text" class="search-input" placeholder="검색어를 입력하세요.">
	<button id="searchButton" class="search-button"><i class="fas fa-search"></i></button> 
			</div>
			</div>
			
				<div class="member_list">
				</div>
</div>
</body>
</html>