<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>유저관리</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
		    border: 1px solid #ddd; 
		    padding: 0px; 
		    border-radius: 5px; 
		    width : 80%;	       	
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
       	.nav-tabs li {
       		width: 50%; 
        }
        .nav-tabs li.active {
	        background-color: #537FE7;
	        color: #fff; 
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
	        max-width: 90%; 
	        margin-top: 20px;
	        margin-left: auto;
	        margin-right: auto;
	        text-align: center;
    	}
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
	        text-align: center;
        }
        .panel {
        	border: none; 
    	}
    	.nav-tabs {
	        margin: 0;
	        padding: 0;
	        border: none;
    	}

    	.nav-tabs > li {
        	margin: 0;
    	}
    	.nav-tabs > li > a {
	        font-size: 20px; 
	        border: none;
	        border-radius: 0;
	        margin: 0;
	        color: #333; 
    	}
    	.nav-tabs > li.active > a,
    	.nav-tabs > li.active > a:hover,
    	.nav-tabs > li.active > a:focus {
	        background-color:  #FFFFFF; 
	        color: #181823; 
    	}
     	.nav-tabs > li > a,
    	.nav-tabs > li > a:hover,
    	.nav-tabs > li > a:focus {
	        background-color: #E2E2E2;
	        color: #181823; 
    	}
</style>
</head>

<body>
<jsp:include page="../include/header.jsp"/>	
<div class="name">
<div>
    <div class="headhead">
        <div class="head">
            <div class="left" onclick="location.href='${contextPath }/admin'">
                <i class="glyphicon glyphicon-chevron-left backleft"></i>
            </div>
            <div class="title">
                <span class="title1">계정 관리/권한</span>
            </div>
        </div>
        </div>
    </div>
    </div>
    <div class="line">
    </div>

    <div class="container-fluid">
        <div class="panel panel-default">
            <ul class="nav nav-tabs">
            <li class="active"><a href="#user" data-toggle="pill">계정관리</a></li>
            <li><a href="#authority" data-toggle="pill">판매자 계정 신청</a></li>
        </ul>
            </div>
            <div class="tab-content">
                <div id="user" class="tab-pane fade in active">
              
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
			
			<script>
			    document.getElementById('searchButton').addEventListener('click', function () {
			        var category = document.getElementById('categorySelect').value;
			        var keyword = document.getElementById('searchInput').value;
			
			        alert('카테고리: ' + category + ', 키워드: ' + keyword);
			       
			    });
			</script>
			
			
				<div class="member_list">
			    <table class="admin_board_wrap" id="user-admin">
			        <thead class="admin_boardList">
			        <th class="admin_board_head">권한</th>
			        <th class="admin_board_head">이름</th>
			        <th class="admin_board_head">전화번호</th>
			        <th class="admin_board_head">가입일자</th>
			        <th class="admin_board_head">계정상태</th>
			        </thead>
			       <tbody>
            <!-- 첫 번째 행 -->
            <tr>
                <td>user</td>
                <td>홍길동</td>
                <td>010-1234-5678</td>
                <td>2023-01-01</td>
                <td>
                    <select class="category-select1">
                        <option value="all">전체</option>
                        <option value="category1" selected>정지</option>
                        <option value="category2">활성화</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>dealer</td>
                <td>길동이</td>
                <td>010-9876-5432</td>
                <td>2023-02-15</td>
                <td>
                    <select class="category-select">
                        <option value="all">전체</option>
                        <option value="category1">카테고리 1</option>
                        <option value="category2" selected>카테고리 2</option>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
				 <div style="text-align: right; margin-top: 20px;">
			        <button style="background-color: #537FE7; color: white; border: none; padding: 8px 12px; border-radius: 0px; cursor: pointer;">적용</button>
			    </div>
                </div>
                </div>
                
                <div id="authority" class="tab-pane fade">
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
			
			<script>
			    document.getElementById('searchButton').addEventListener('click', function () {
			        var category = document.getElementById('categorySelect').value;
			        var keyword = document.getElementById('searchInput').value;
			
			        alert('카테고리: ' + category + ', 키워드: ' + keyword);
			       
			    });
			</script>
			
			
				<div class="member_list">
			    <table class="admin_board_wrap" id="user-admin">
			        <thead class="admin_boardList">
			        <th class="admin_board_head">아이디</th>
			        <th class="admin_board_head">이름</th>
			        <th class="admin_board_head">전화번호</th>
			        <th class="admin_board_head">가입일자</th>
			        <th class="admin_board_head">권한</th>
			        </thead>
			       <tbody>
            	
            <tr>
                <td>user</td>
                <td>홍길동</td>
                <td>010-1234-5678</td>
                <td>2023-01-01</td>
                <td>
                     <button class="btn" style="background-color: #537FE7; color: #fff;">수락</button>
                </td>
            </tr>
         
        </tbody>
    </table>
                </div>
                </div>
                </div>
                </div>
                
   
</body>
</html>