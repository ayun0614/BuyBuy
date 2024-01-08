<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

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
        .chart-circle{
        	float: left;
        	margin-top: 0px;
        	margin-left: 0x;
        }
        .bottom{
         display: flex;
        }
        
        .fast {
            float: right; 
            margin-top: 0px;
            margin-bottom: 0px;
            display: flex;
            flex-direction: column; 
            align-items: flex-end;
        }
        .btn1 {
            width: 200px; 
            height: 80px; 
            padding: 10px 20px; 
            font-weight: bold; 
            text-align: center; 
            margin-top: 0px;
            margin: 5px;
            border: none;
            cursor: pointer;
            border-radius: 0px; 
        }
	    canvas {
        	margin: 0px 0;
  		}
  		.chart-stick{
        	margin-left: 1000!important;
  		}
   		#visitorChart {  
   			float: center; 
        	max-width: 1200px; 
        	height: 200px; 
        	margin-left: 100;
        	display: block;
    	}
    	#myDoughnutChart{
    		float: left;
    		width: 100%;
    		height: 100%;
    		display: block;
    		margin-left: 0px;
    	}
    	#calendar {
		    margin-top: 5px;	
		    max-width: 300px; 
		    max-height: 100px;
		    float: left;
		    margin-left: 100px; 
        }
    	#calendar .fc-button {
		    background-color: #537FE7 !important; 
		    color: #fff !important; 
		    border: none !important; 
		    box-shadow: none !important;
		}
		#calendar .fc-button-active {
	    	background-color: #4251A3 !important; 
	    	color: #fff !important; 
	    	border: none !important; 
	    	box-shadow: none !important; 
		}	
		#calendar .fc-today {
		    background-color: #537FE7 !important; 
		    border-color: #537FE7 !important; 
		    color: #fff !important; 
		}
		.fc-right {
		    display: block;
		    padding: 0;
		    margin: 0;
		    clear: both; 
		}
        .fc-left {
            display: none; 
        }
        .fc-center h2 {
            display: none; 
        }
</style>
</head>

<body>
<jsp:include page="../include/header.jsp"/>
<div class="name">
<div>
    <div class="headhead">
        <div class="head">
            <div class="title">
                <span class="title1">사이트 관리</span>
            </div>
        </div>
        </div>
    </div>
    </div>
    <div class="line">
    </div>
<div class="container" style="text-align: center;">
		<div class="fast">
    	<button class="btn1" style="background-color: #537FE7; color: #fff;" onclick="location.href='${contextPath }/admin/postmanagement'">게시글 관리</button>
    	<button class="btn1" style="background-color: #537FE7; color: #fff;" onclick="location.href='${contextPath }/admin/usermanagement'">계정관리</button>
   		<button class="btn1" style="background-color: #537FE7; color: #fff;" onclick="location.href='${contextPath }/admin/bannercontrol'">배너관리</button>
   		</div>
<div class="chart-circle">
	<canvas id="myDoughnutChart" width="300" height="300"></canvas>
    <script>
    var ctxDoughnut = document.getElementById('myDoughnutChart').getContext('2d');
    var dataDoughnut = {
        labels: ['카카오 로그인', '구글 로그인', '네이버 로그인','일반 로그인'],
        datasets: [{
            data: [0, 0, 0,0],
            backgroundColor: [
                'rgba(255, 99, 132, 0.7)',
                'rgba(54, 162, 235, 0.7)',
                'rgba(255, 206, 86, 0.7)',
                'rgba(10, 10, 10, 10)'
            ],
            hoverBackgroundColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(10, 10, 10, 10)'
            ]
        }]
    };

    var myDoughnutChart = new Chart(ctxDoughnut, {
        type: 'doughnut',
        data: dataDoughnut,
        options: {
            plugins: {
                legend: {
                    display: true,
                    position: 'right', 
                    labels: {
                        font: {
                            size: 12 
                        }
                    }
                }
            }
        }
    });
    $.ajax({
        url: "admindonut", 
        method: "get",
        dataType: "json",
        success: function (response) {
            console.log(response);
            dataDoughnut.datasets[0].data = [response[0].kakao, response[0].google, response[0].naver, response[0].normal];
            myDoughnutChart.update();
        },
        error: function (error) {
            console.error('데이터를 불러오는 중 에러 발생:', error);
        }
    });
    </script>
</div>
<div id="calendar"></div>
    <div class="chart-stick">
        <canvas id="myChart" style="width: 100%; height: 200px; margin: 0 auto; float: left; display: block;"></canvas>
    </div>

   <script>
    jQuery.noConflict();
    jQuery(document).ready(function () {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'prev,next today'
            },
            editable: false,
            events: [],
            dayClick: function (date, jsEvent, view) {
                alert('Clicked on: ' + date.format());
                fetchData(date.format());
            }
        });
    });

    const ctx = document.getElementById('myChart').getContext('2d');

    const datavisitorDatasets = [{
        label: '실시간 구입 현황',
        data: [],
        backgroundColor: 'rgba(83, 127, 231, 0.2)',
        borderColor: 'rgba(83, 127, 231, 1)',
        borderWidth: 2,
        pointRadius: 5,
        pointBackgroundColor: 'rgba(83, 127, 231, 1)',
        pointBorderColor: '#fff',
        pointHoverRadius: 8,
        lineTension: 0.3,
    }];

    let myChart;

    function initChart() {
        myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['0시', '1시', '2시', '3시', '4시', '5시', '6시', '7시', '8시', '9시', '10시', '11시', '12시',
                    '13시', '14시', '15시', '16시', '17시', '18시', '19시', '20시', '21시', '22시', '23시'],
                datasets: datavisitorDatasets,
            },
            options: {
                scales: {
                    x: {
                        grid: {
                            drawOnChartArea: true,
                        },
                        ticks: {
                            display: true,
                        }
                    },
                    y: {
                        display: false,
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        onClick: function (event, legendItem) {
                           
                        }
                    }
                }
            }
        });
    }

    initChart();

    function fetchData(date) {
        $.ajax({
            url: "adminchart",
            method: "get",
            dataType: "json",
            data: { date: date },
            success: function (response) {
                console.log(response);
                if (response && response[0]) {
                    datavisitorDatasets[0].data = [
                        response[0].total_quantity_0, response[0].total_quantity_1, response[0].total_quantity_2, response[0].total_quantity_3,
                        response[0].total_quantity_4, response[0].total_quantity_5, response[0].total_quantity_6, response[0].total_quantity_7,
                        response[0].total_quantity_8, response[0].total_quantity_9, response[0].total_quantity_10, response[0].total_quantity_11,
                        response[0].total_quantity_12, response[0].total_quantity_13, response[0].total_quantity_14, response[0].total_quantity_15,
                        response[0].total_quantity_16, response[0].total_quantity_17, response[0].total_quantity_18, response[0].total_quantity_19,
                        response[0].total_quantity_20, response[0].total_quantity_21, response[0].total_quantity_22, response[0].total_quantity_23
                    ];
                } else {
                    console.error('Invalid server response:', response);
                }
                myChart.update();
            },
            error: function (error) {
                console.error('데이터를 불러오는 중 에러 발생:', error);
                alert("에러");
            }
        });
    }
    function today() {
        $.ajax({
            url: "admintoday",
            method: "get",
            dataType: "json",
            success: function (response) {
                console.log(response);
                if (response && response[0]) {
                    datavisitorDatasets[0].data = [
                        response[0].total_quantity_0, response[0].total_quantity_1, response[0].total_quantity_2, response[0].total_quantity_3,
                        response[0].total_quantity_4, response[0].total_quantity_5, response[0].total_quantity_6, response[0].total_quantity_7,
                        response[0].total_quantity_8, response[0].total_quantity_9, response[0].total_quantity_10, response[0].total_quantity_11,
                        response[0].total_quantity_12, response[0].total_quantity_13, response[0].total_quantity_14, response[0].total_quantity_15,
                        response[0].total_quantity_16, response[0].total_quantity_17, response[0].total_quantity_18, response[0].total_quantity_19,
                        response[0].total_quantity_20, response[0].total_quantity_21, response[0].total_quantity_22, response[0].total_quantity_23
                    ];
                } else {
                    console.error('Invalid server response:', response);
                }
                myChart.update();
            },
            error: function (error) {
                console.error('데이터를 불러오는 중 에러 발생:', error);
                alert("에러");
            }
        });
    }
    
    
	$(document).ready(function(){
		today();
	});
</script>

</div>
    </div>   	
</body>
</html>