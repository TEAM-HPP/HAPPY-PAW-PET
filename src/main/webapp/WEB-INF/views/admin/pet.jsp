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
	<link rel="stylesheet" type="text/css" href="/css/admin/adminPet.css" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		function search() {
			$(".container").css("display","inline-block");
			let r_label = [];
			let r_data = [];

			let uprCd = $("#uprCd").val();
			//console.log("지역 : "+uprCd);

			// 차트 초기화
			let chartStatus = Chart.getChart("animalChart"); // <canvas> id
			if (chartStatus != undefined) {
				chartStatus.destroy();
			}

			r_label = [];
			r_data = [];


			$.ajax({
				url: "/admin/animalChart",
				type: "post",
				data: {"uprCd":uprCd},
				dataType: "json",
				success: function(data){
					const countMap = data.countMap;

					for (const [orgdownNm, count] of Object.entries(countMap)) {
						r_label.push(orgdownNm);
						r_data.push(count);
					}


					// totalCount를 id가 totalCount인 span에 설정
					$("#totalCount").text(data.totalCount);


					const ctx = document.getElementById('animalChart').getContext('2d');
					new Chart(ctx, {
						type: 'bar',
						data: {
							labels: r_label,
							datasets: [{
								label: '지역별 유기동물 공고 수',
								data: r_data,
								borderWidth: 2,
								backgroundColor: ['#DABEEE','#CFEFE1','#F0E6B1','#EFB8B0','#9FA0F0','#BDF0DF']
							}]
						},
						options: {
							responsive: true,
							plugins: {
								title: {
									display: true,
									text: '지역별 유기동물 공고 수',
									font: {
										size: 20,
										weight: 'bold'
									}
								},
								datalabels: {
									formatter: (value, ctx) => {
										let sum = 0;
										let dataArr = ctx.chart.data.datasets[0].data;
										dataArr.map(data => {
											sum += data;
										});
									},
									color: 'black',
									font: {
										weight: 'bold'
									}
								}
							},
							maintainAspectRatio: false,
							scales: {
								x: {
									grid: {
										display: false
									}
								},
								y: {
									display: false,
									grid: {
										display: false
									}
								}
							}
						},
						plugins: [ChartDataLabels]
					});//차트
				}, // success
				error: function(){
					alert("실패");
				} // error
			});// ajax

		}//버튼 클릭
	</script>
	<title>HappyPawPet 관리자페이지</title>
</head>
<body id="admin">
<%@ include file="../top/adminTop.jsp" %>
<!-- ------------------------------------------------------------------------- -->
<section>
	<%@ include file="../admin/subbanner.jsp" %>
	<div class="main">
		<h2><span>반려동물관리</span></h2>
		<div class="animalList">
			<h4>유기동물 공고 지역별 현황 (총&ensp;<span id="totalCount">${totalCount }</span>건)</h4>
			<div class="filters">
				<form action="/admin/animalChart" method="post">
					<select name="uprCd" id="uprCd">
						<option value="">전국</option>
						<c:forEach items="${sidoList}" var="sido">
							<option value="${sido.orgCd}" ${sido.orgCd == uprCd ? 'selected' : ''}>${sido.orgdownNm}</option>
						</c:forEach>
					</select>
					<button type="button" onclick="search()">조회</button>
				</form>
			</div>
			<div class="container">
				<canvas id="animalChart"></canvas>
			</div>


		</div>
		<div class="petlist">
			<h4>등록 반려동물 현황 (총 ${plist.size()} 마리)</h4>
			<table id="pet">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 15%;"/>
					<col style="width: 10%;"/>
					<col style="width: 13%;"/>
					<col style="width: 12%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>회원아이디</th>
					<th>반려동물 이름</th>
					<th>무게(kg)</th>
					<th>생일</th>
					<th>성별</th>
					<th>중성화여부</th>
					<th>보호자정보</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${ plist}" var="pDto">
					<tr>
						<td>${pDto.id }</td>
						<td>${pDto.pname}</td>
						<td>${pDto.pweight }</td>
						<td><fmt:formatDate value="${pDto.pbirth }" pattern="yyyy-MM-dd"/></td>
						<td>${pDto.pgender }</td>
						<td>${pDto.psurgery }</td>
						<td id="button"><div id="memInfo"><a href="/admin/memDetail?id=${pDto.id }">확인</a></div></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- ----------------------------------------------------------------------------- -->
</section>
</body>
</html>