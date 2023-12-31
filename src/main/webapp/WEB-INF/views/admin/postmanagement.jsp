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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		waitList();
	});
	
	function waitList(){
		$.ajax({
			url:"post",
			type:"get",
			dataType:"json",
			success:createView, 
			error:function(){
				alert("waitlisterror");
			}
		});
	}
	  function createView(data) {
            var list = "<table class='admin_board_wrap' id='user-admin'>";
            list += "<thead class='admin_boardList' >"; 
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
                list += "<td>" + obj.member_id + "</td>";
                list += "<td>" + obj.product_idx + "</td>";
                list += "<td>" + obj.product_name + "</td>";
                list += "<td>" + obj.ctgr_name + "</td>";
                list += "<td>" + obj.start_date + "</td>";
                list += "<td><button class='btn btn-danger' onclick='fDelete("+obj.product_idx+")'>삭제</button></td>";
                list += "</tr>";
            });

            list += "</tbody>";
            list += "</table>";
            
		$("#member_list").html(list);
          
        }
	  function fDelete(product_idx){
			$.ajax({
				url:"${contextPath}/admin/deletePo?product_idx=" + product_idx,
				type:"DELETE",
				success:waitList,
				error:function(){
					alert("삭제실패");
				}
					
			});
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
		    overflow: visible !important;
	   		margin-top: 20px;
	    	text-align: center;  	
	    	max-width:80%;
		    height: 100vh;
		    position: relative;
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
        h1 {
        	border-bottom: 2px solid #E2E2E2;
        	padding-bottom: 20px;
        	margin-bottom: 20px;
        }
        .search-bar {
        	display: flex;
        	align-items: center;
        	justify-content: center; 
        	position: absolute;
  			top: 35px;
			left: 46px;
    	}
    	.search-bar-content {
    		color: #000;
        	display: flex;
        	justify-content: space-around;
        	justify-content: flex-start;
        	margin-left: auto;
        	margin-right: auto;
    	}
    	.category-select,
    	.search-button {
        	margin-right: 8px; 
        	height: 47px;
        	width: 47px;
    	}
    	.search-input {
    		height: 47px;
    		width: 300px;
	        flex-grow: 1;
	        padding: 8px 20px; 
	        border: 1px solid #E2E2E2;
	        max-width: 120%;
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
        	overflow: visible !important;
	        border-collapse: collapse;
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
        	text-align: center; 
	        background-color: #f2f2f2;
        }
         th:nth-child(1), td:nth-child(1) {
	        width: 50px;
	    }
	
	    th:nth-child(2), td:nth-child(2) {
	        width: 40px;
	    }
	    th:nth-child(3), td:nth-child(3) {
	        width: 360px;
	    }
	    th:nth-child(4), td:nth-child(4) {
	        width: 60px;
	    }
	    th:nth-child(5), td:nth-child(5) {
	        width: 70px;
	    }
	    th:nth-child(6), td:nth-child(5) {
	        width: 30px;
	    }
        .admin_board_wrap {
    		overflow: visible !important;
        	width: 95%;
        	margin-top: 110px;
        	margin-left: auto;
        	margin-right: auto;
        	text-align: center;
    	}
        .admin_board_head {
        	padding: 8px; 
        	text-align: center; 
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
            <div class="left" onclick="location.href='${contextPath }/admin/admin'">
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
			  <option value="product_name">제목 </option>
			  <option value="member_id">판매자 아이디</option>
			  <option value="product_idx">상품 ID</option>
			  <option value="ctgr_name">카테고리</option>
		</select></div>
	<input id="searchInput" type="text" class="search-input" placeholder="검색어를 입력하세요.">
	<button id="searchButton" class="search-button"><i class="fas fa-search"></i></button> 
			
			<script>
    $(document).ready(function () {
        $("#searchButton").on("click", function () {
            performSearch();
        });
        $("#searchInput").keypress(function (e) {
            if (e.which === 13) {
                performSearch();
            }
        });
        function performSearch() {
            var category = $("#categorySelect").val();
            var searchTerm = $("#searchInput").val();
            if (searchTerm.trim() === "") {
            	location.reload();
            } else {
                searchpost(category, searchTerm);
            }
        }
        function searchpost(category, searchTerm) {
            $.ajax({
                url: "searchpost",
                method: "get",
                dataType: "json",
                data: {
                    category: category,
                    searchTerm: searchTerm
                },
                success: function (response) {
                	createView(response); 
                },
                error: function (error) {
                    console.error('데이터를 불러오는 중 에러 발생:', error);
                    alert("에러");
                }
            });
        }
    });
</script>
			</div>
			
				<div id="member_list"></div>
</div>
</body>
</html>