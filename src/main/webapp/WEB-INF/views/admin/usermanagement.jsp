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
		
		DataApproveView();
	});
	$(document).ready(function(){
		waitList();
		
	});
	

function waitList(){
		$.ajax({
			url:"user",
			type:"get",
			dataType:"json",
			success:
				createUserView, 
			error:function(){
				alert("error");
			}
		});
	}
	 
	  function createUserView(data) {
          var list = "<table class='admin_board_wrap' id='user-admin'>";
          list += "<thead class='admin_boardList'>"; 
          list += "<th class='admin_board_head'>아이디</th>"; 
          list += "<th class='admin_board_head'>이름</th>"; 
          list += "<th class='admin_board_head'>전화번호</th>"; 
          list += "<th class='admin_board_head'>가입일자</th>"; 
          list += "<th class='admin_board_head'>권한</th>"; 
          list += "</thead>";
          list += "<tbody id='user-admin-body1'>";
         
          $.each(data, function (index, obj) {
              list += "<tr>";
              list += "<td>" + obj.member_id + "</td>";
              list += "<td>" + obj.name + "</td>";
              list += "<td>" + obj.phone + "</td>";
              list += "<td>" + obj.join_date + "</td>";
              list += "<td><button onclick='approveUser(this)' id='button1'>승인</button> <button onclick='refuseUser(this)' id='button2'>거절</button></td>";
              list += "</tr>";
          });

          list += "</tbody>";
          list += "</table>";
          
		$("#member_authority").html(list);
		
        }
	  
	  function refuseUser(button){
		  var member_id = $(button).closest('tr').find('td:first').text();
		  $.ajax({
				url:"${contextPath}/admin/refuseUser?member_id=" + member_id,
				type:"DELETE",
				success: function(response) {
		            alert('판매자 권한 신청을 거절했습니다.');
		            waitList();
		        },
				error:function(){
					alert("삭제실패");
				}
					
			});
	  }
	  function approveUser(button) {
		    var member_id_value = $(button).closest('tr').find('td:first').text();
		    $.ajax({
		        type: 'POST', 
		        url: 'updateMember', 
		        data: { member_id: member_id_value },
		        success: function(response) {
		            alert('신청이 수락되었습니다.');
		            waitList();
		        },
		        error: function(xhr, status, error) {
		        	 console.error('에러 상태:', status);
		             console.error('에러 내용:', error);
		             console.error('XHR 객체:', xhr);
		             alert('업데이트에 실패했습니다. 자세한 내용은 콘솔을 확인하세요.');
		        }
		    });    
		}
	
	  
	
	  function DataApproveView() {
		    $.ajax({
		        url: "approve",
		        type: "get",
		        dataType: "json",
		        success: createApproveView,
		        error: function () {
		            alert("error22");
		        }
		    });
		}

		function createApproveView(data) {
		    var list = "<table class='admin_board_wrap' id='user-admin'>";
		    list += "<thead class='admin_boardList'>";
		    list += "<th class='admin_board_head'>권한</th>";
		    list += "<th class='admin_board_head'>이름</th>";
		    list += "<th class='admin_board_head'>전화번호</th>";
		    list += "<th class='admin_board_head'>가입일자</th>";
		    list += "<th class='admin_board_head'>계정상태</th>";
		    list += "</thead>";
		    list += "<tbody id='user-admin-body1'>";

		    $.each(data, function (index, obj) {
		        list += "<tr>";
		        list += "<td>" + obj.account_type + "</td>";
		        list += "<td>" + obj.name + "</td>";
		        list += "<td>" + obj.phone + "</td>";
		        list += "<td>" + obj.join_date + "</td>";
		        list += "<td>" + getCategorySelect(obj.name, obj.account_status) + "</td>";
		        list += "</tr>";
		    });

		    list += "</tbody>";
		    list += "</table>";
		
		    $("#user1").html(list);

		    function getCategorySelect(name, status) {
		        var selectHTML = "<select class='category-select'>";
		        switch (status) {
		            case "activate":
		                selectHTML += "<option value='activate' selected>활성화</option>";
		                selectHTML += "<option value='inactivate'>비활성화</option>";
		                break;
		            case "inactive":
		                selectHTML += "<option value='activate'>활성화</option>";
		                selectHTML += "<option value='inactivate' selected>비활성화</option>";
		                break;
		            default:
		                selectHTML += "<option value='activate'>활성화</option>";
		                selectHTML += "<option value='inactivate' selected>비활성화</option>";
		                break;
		        }
		        selectHTML += "</select>";
		        return selectHTML;
		    }

		    $(document).on('change', '.category-select', function () {
		        var name = $(this).closest("tr").find("td:eq(1)").text(); // '이름' 열 값 가져오기
		        var account_status = $(this).val();
		        console.log("입ㄹ");
		        console.log("New Status: " + account_status);
		        console.log("name " + name);

		        $.ajax({
		            url: "updateStatus",
		            type: "post",
		            dataType: "text",
		            data: {
		                name: name,
		                account_status: account_status
		            },
		            success: function (response) {
		                console.log("상태가 성공적으로 업데이트되었습니다");
		                alert("적용 되었습니다");
		            },
		            error: function () {
		                alert("상태 업데이트 중 오류가 발생했습니다");
		            }
		        });
		    });
		}
		

</script>


<style>
		#button2{
			background-color: red;
		    border: none;
		    color:white;
		}
		#button1{
			background-color: #537FE7;
		    border: none;
		    color:white;
		}
		.active-select{
			width:100px;
			height: 40px;
		}
		.category-button {
	        background-color: #fff; 
	        color: #000 !important; 
	        font-weight: bold; 
	        margin-right: 8px;
	        width: 55px; 
	       	border: 1px solid #E2E2E2;
    	}
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
       	.nav-tabs li {
       		width: 50%; 
        }
        .nav-tabs li.active {
	        background-color: #537FE7;
	        color: #fff; 
        }
        h1 {
	        border-bottom: 2px solid #E2E2E2;
	        padding-bottom: 20px;
	        margin-bottom: 20px;
        }
        .search-bar {
		    display: flex;
		    justify-content: flex-start; /* !important 제거 */
		    text-align: left;
		    margin-bottom: 20px;
		    position: absolute;
			top: 80px;
			left: 46px;
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
	        max-width: 100%; 
	        margin-top: 100px;
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
	        margin-right: 8px; 
        	height: 47px;
        	width: 47px;
    	}
        table {
	        border-collapse: collapse;
	        width: 95%; 
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
        th:nth-child(1), td:nth-child(1) {
	        width: 100px;
	    }
	
	    th:nth-child(2), td:nth-child(2) {
	        width: 150px;
	    }
	
	    th:nth-child(3), td:nth-child(3) {
	        width: 120px;
	    }
	
	    th:nth-child(4), td:nth-child(4) {
	        width: 160px;
	    }
	
	    th:nth-child(5), td:nth-child(5) {
	        width: 80px;
	    }
        .search-input {
	        flex-grow: 1;
	        padding: 8px 20px; 
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
        td select {
        	max-width: 100%; 
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
            <div class="left" onclick="location.href='${contextPath }/admin/admin'">
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
            <li class="active"><a href="#member_list" data-toggle="pill">계정관리</a></li>
            <li><a href="#authority" data-toggle="pill">판매자 계정 신청</a></li>
        </ul>
     </div>
     
     
     <div class="tab-content">
     
           <div id="member_list" class="tab-pane fade in active">
                 <div class="search-bar">
                 <div class="search-bar-content">
		   			 <button id="categoryButton" class="category-button" disabled>이름</button>
			    <input id="searchInput" type="text" class="search-input" placeholder="검색어를 입력하세요.">
			    <button id="searchButton" class="search-button"><i class="fas fa-search"></i></button> 
				</div>
				</div>		

	<div id="member_list">
		<div id="user1"></div>   
			</div>
			<script>
			document.getElementById('searchButton').addEventListener('click', function () {
			    var name = document.getElementById('searchInput').value;
			    if (name == "") {
	            	location.reload();
	            } else {
	            	search(name);
	            }
			});
			  function search(name) {
			        $.ajax({
			            url: "search",
			            method: "get",
			            dataType: "json",
			            data: { name: name },
			            success: function (response) {
			                createApproveView(response); 
			            },
			            error: function (error) {
			                console.error('데이터를 불러오는 중 에러 발생:', error);
			                alert("에러");
			            }
			        });
			    }
			
			</script>
    </div>

          
          
     <div id="authority" class="tab-pane fade">
             
			<div id="member_authority"></div>
      </div>
      </div>
</div>
               
                
   
</body>
</html>