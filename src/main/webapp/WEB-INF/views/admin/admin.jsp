<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/admin/adminTop.css" />
	<link rel="stylesheet" type="text/css" href="/css/admin/subbanner.css" />
	<link rel="stylesheet" type="text/css" href="/css/admin/admin.css" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>HappyPawPet 관리자페이지</title>
</head>
<script type="text/javascript">
	var xmlHttp;

	function srvTime() {
		try {
			// FF, Opera, Safari, Chrome
			xmlHttp = new XMLHttpRequest();
		} catch (err1) {
			// IE
			try {
				xmlHttp = new ActiveXObject('Msxml2.XMLHTTP');
			} catch (err2) {
				try {
					xmlHttp = new ActiveXObject('Microsoft.XMLHTTP');
				} catch (err3) {
					// AJAX not supported, use CPU time.
					alert("AJAX not supported");
					return new Date().toUTCString(); // 클라이언트 시간을 반환
				}
			}
		}
		xmlHttp.open('HEAD', window.location.href.toString(), false);
		xmlHttp.setRequestHeader("Content-Type", "text/html");
		xmlHttp.send('');
		return xmlHttp.getResponseHeader("Date");
	}

	function updateTimes() {
		var st = srvTime();
		var serverTime = new Date(st);
		var localTime = new Date();

		//console.log("Local machine time is: " + localTime);
		//console.log("Server time is: " + serverTime);

		document.getElementById("localTime").innerText = localTime;
		document.getElementById("serverTime").innerText = serverTime;
	}
	function startUpdating(){
		updateTimes();
		setInterval(updateTimes, 1000); //1초마다 없데이트
	}

	window.onload = startUpdating;
</script>
<body id="admin">
<%@ include file="../top/adminTop.jsp" %>
<!-- ------------------------------------------------------------------------- -->
<section>
	<%@ include file="../admin/subbanner.jsp" %>
	<div class="main">
		<h2><span>관리자 메인</span></h2>
		<div class="servTime">
			<h2>Local Machine Time</h2>
			<span id="localTime"></span>
			<h2>Server time</h2>
			<span id="serverTime"></span>
		</div>
		<div class="analytics">
			<h2><span>사이트 이벤트 통계</span></h2>
			<div id="data-container">
	    		<div class="contain1">
		    		<canvas id="myChart"></canvas>
		    		<canvas id="myChart2"></canvas>
	    		</div>
	    		<div class="contain2">
		    		<canvas id="myChart3"></canvas>
		    		<canvas id="myChart4"></canvas>
	    		</div>
	    	</div>
	    </div>
	</div>
	<!-- ---------------------------------------------------------------------------------- -->
	<script>
		fetch('/admin/analyticsTest')
    		.then(response => response.json())
			.then(data => {
            const labels = data.map(entry => entry.date);
            const active7DayUsers = data.map(entry => entry.active7DayUsers);
            const averageSessionDuration = data.map(entry => parseFloat(entry.averageSessionDuration)/60);
            const newUsers = data.map(entry => entry.newUsers);
            const screenPageViews = data.map(entry => entry.screenPageViews);

            // Chart for Active 7-Day Users
            const ctx = document.getElementById('myChart').getContext('2d');
            let myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Active 7-Day Users',
                        data: active7DayUsers,
                        backgroundColor: 'rgba(225, 222, 216, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                        fill:true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: '7일간 활성 사용자',
                            font: {
                                size: 20,
                                weight: 'bold'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 5 
                            }
                        }
                    },
                    maintainAspectRatio: true
                }
            });

            // Chart for Average Session Duration
            const ctx2 = document.getElementById('myChart2').getContext('2d');
            let myChart2 = new Chart(ctx2, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Average Session Duration',
                        data: averageSessionDuration,
                        backgroundColor: 'rgba(225, 222, 216, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1,
                        fill:true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: '평균 체류시간',
                            font: {
                                size: 20,
                                weight: 'bold'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 5 
                            }
                        }
                    },
                    maintainAspectRatio: true
                }
            });

            // Chart for New Users
            const ctx3 = document.getElementById('myChart3').getContext('2d');
            let myChart3 = new Chart(ctx3, {
                type: 'line',
                data: {
                    labels: labels, 
                    datasets: [{
                        label: 'New Users',
                        data: newUsers,
                        backgroundColor: 'rgba(225, 222, 216, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1,
                        fill:true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: '새로운 사용자 유입',
                            font: {
                                size: 20,
                                weight: 'bold'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true, 
                            ticks: {
                                stepSize: 5 
                            }
                        }
                    },
                    maintainAspectRatio: true
                }
            });

            // Chart for Screen Page Views
            const ctx4 = document.getElementById('myChart4').getContext('2d');
            let myChart4 = new Chart(ctx4, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Screen Page Views',
                        data: screenPageViews,
                        backgroundColor: 'rgba(225, 222, 216, 0.6)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1,
                        fill:true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: '페이지 조회수',
                            font: {
                                size: 20,
                                weight: 'bold'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true, 
                            ticks: {
                                stepSize: 5 
                            }
                        }
                    },
                    maintainAspectRatio: true
                }
            });

        }).catch(error => console.error('Error fetching data:', error));
</script>
</section>
</body>
</html>