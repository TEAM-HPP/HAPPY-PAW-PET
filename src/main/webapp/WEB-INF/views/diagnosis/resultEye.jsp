<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="stylesheet" type="text/css" href="/css/top.css">
	<link rel="stylesheet" type="text/css" href="/css/diagnosis/dom.css">
	<link rel="stylesheet" type="text/css" href="/css/footer.css">
	<title>HappyPawPet 진단내역</title>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function(){
			const probability = ${probability}; // 서버에서 동적으로 주어지는 값

		    // 확률을 퍼센트로 변환
		    const probabilityPercentage = probability * 100;

		    // Chart.js 가로 막대 차트 생성
		    const ctx = document.getElementById('probabilityChart').getContext('2d');
		    const probabilityChart = new Chart(ctx, {
		        type: 'bar',
		        data: {
		            labels: [''],
		            datasets: [{
		                label: '확률',
		                data: [probabilityPercentage],
		                backgroundColor: '#DA958C',
		                borderSkipped: false
		            }]
		        },
		        options: {
		            indexAxis: 'y',
		            scales: {
		                x: {
		                    beginAtZero: true,
		                    max: 100,
		                    grid: {
		                        display: false
		                    }
		                    
		                },
		                y: {
		                    grid: {
		                        display: false
		                    },
		                    ticks: {
		                        display: false
		                    }
		                }
		            },
		            responsive: true,
		            maintainAspectRatio: false,
		            plugins: {
		                legend: {
		                    display: false
		                },
		                tooltip: {
		                    enabled: true
		                }
		            },
		            layout: {
		                padding: {
		                    right: 100 - probabilityPercentage
		                }
		            }
		        }
		    });
	});
	</script>
</head>
<body>
<%@ include file="../top/top.jsp" %>
<section>
	<div id="blank"></div>
	<div class="box1">
		<h2 id="heading">${userId}님의 반려동물 안구진단</h2>
		<div id="content-container">
			<div id="prod-img">
	<%--			<img src="/Users/igyuwon/upload/${param.file}" alt="Uploaded Pet Image" width="600" height="400">--%>
				<img src="${pageContext.request.contextPath}/upload/${param.file}" alt="Uploaded Pet Image" width="400" height="400">
			</div>
			<div id="result">
				<h2 class="resultTitle">진단 결과</h2>
				<p class="resultText">‘${userId} 님의 반려견 ${petName}(강아지 이름)의 의심 질환은 <span>‘${disease}’</span>입니다.</p>
				<div class="chart">
				<p class="resultText" id="percentage">확률: <span>${probability * 100}%</span></p>
				<canvas id="probabilityChart"></canvas>
				</div>
			</div>
		</div>
	</div>

	<div id="information">
		<div id="drug">
			<h3 class="subTitle">추천 강아지 영양제</h3>
			<ul>
				<c:forEach var="product" items="${nutritionProducts}">
					<li>
						<img src="${product.imgFile}" alt="${product.name}">
						<p><a href="${product.url}">${product.name}</a></p>
						<p>${product.price}</p>
						<button type="button" class="navyBtn" onClick="location.href='${product.url}'">해당 홈페이지 바로가기</button>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div id="food">
			<h3 class="subTitle">추천 강아지 사료</h3>
			<ul>
				<c:forEach var="product" items="${foodProducts}">
					<li>
						<img src="${product.imgFile}" alt="${product.name}">
						<p><a href="${product.url}">${product.name}</a></p>
						<p>${product.price}</p>
						<button type="button" class="navyBtn" onClick="location.href='${product.url}'">해당 홈페이지 바로가기</button>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div id="medicine">
			<h3 class="subTitle">추천 강아지 안약</h3>
			<ul>
				<c:forEach var="product" items="${medicineProducts}">
					<li>
						<img src="${product.imgFile}" alt="${product.name}">
						<p><a href="${product.url}">${product.name}</a></p>
						<p>${product.price}</p>
						<button type="button" class="navyBtn" onClick="location.href='${product.url}'">해당 홈페이지 바로가기</button>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</section>
<%@ include file="../footer/footer.jsp" %>
</body>
</html>