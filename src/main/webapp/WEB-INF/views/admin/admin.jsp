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
<script>
$(document).ready(function() {
    const ctx = document.getElementById('myChart').getContext('2d');
    let myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [], // 초기 레이블
            datasets: [{
                label: 'Active 7-Day Users',
                data: [], // 초기 데이터
                borderColor: 'orange',
                borderWidth: 1,
                fill: true
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
                    beginAtZero: true, // y축이 0부터 시작하도록 설정
                    ticks: {
                        stepSize: 5 // y축 간격을 5로 설정
                    },
                    suggestedMax: function(context) {
                        const maxValue = Math.max(...context.chart.data.datasets[0].data);
                        return maxValue + 5; // y축의 최대값을 데이터의 최대값보다 5만큼 많게 설정
                    }
                }
            },
            maintainAspectRatio: true
        }
    });
	
    const ctx2 = document.getElementById('myChart2').getContext('2d');
    let myChart2 = new Chart(ctx2, {
        type: 'line',
        data: {
            labels: [], // 초기 레이블
            datasets: [{
                label: 'Average Session Duration',
                data: [], // 초기 데이터
                borderColor: 'red',
                borderWidth: 1,
                fill: true
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
                    beginAtZero: true, // y축이 0부터 시작하도록 설정
                    ticks: {
                        stepSize: 5 // y축 간격을 5로 설정
                    },
                    suggestedMax: function(context) {
                        const maxValue = Math.max(...context.chart.data.datasets[0].data);
                        return maxValue + 5; // y축의 최대값을 데이터의 최대값보다 5만큼 많게 설정
                    }
                }
            },
            maintainAspectRatio: true
        }
    });
    const ctx3 = document.getElementById('myChart3').getContext('2d');
    let myChart3 = new Chart(ctx3, {
        type: 'line',
        data: {
            labels: [], // 초기 레이블
            datasets: [{
                label: 'New Users',
                data: [], // 초기 데이터
                borderColor: 'blue',
                borderWidth: 1,
                fill: true
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
                    beginAtZero: true, // y축이 0부터 시작하도록 설정
                    ticks: {
                        stepSize: 5 // y축 간격을 5로 설정
                    },
                    suggestedMax: function(context) {
                        const maxValue = Math.max(...context.chart.data.datasets[0].data);
                        return maxValue + 5; // y축의 최대값을 데이터의 최대값보다 5만큼 많게 설정
                    }
                }
            },
            maintainAspectRatio: true
        }
    });
    const ctx4 = document.getElementById('myChart4').getContext('2d');
    let myChart4 = new Chart(ctx4, {
        type: 'line',
        data: {
            labels: [], // 초기 레이블
            datasets: [{
                label: 'Screen/Page Views',
                data: [], // 초기 데이터
                borderColor: 'green',
                borderWidth: 1,
                fill: true
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
                    beginAtZero: true, // y축이 0부터 시작하도록 설정
                    ticks: {
                        stepSize: 5 // y축 간격을 5로 설정
                    },
                    suggestedMax: function(context) {
                        const maxValue = Math.max(...context.chart.data.datasets[0].data);
                        return maxValue + 5; // y축의 최대값을 데이터의 최대값보다 5만큼 많게 설정
                    }
                }
            },
            maintainAspectRatio: true
        }
    });
   
    // 현재날짜 ~ 7일 전 날짜 생성------------------------------------
    function getLast7Days() {
        let labels = [];
       
        let currentDate = new Date();
       
        for (let i = 0; i < 7; i++) {
            let date = new Date(currentDate);
            labels.unshift(date.toISOString().split('T')[0]);
            currentDate.setDate(currentDate.getDate() - 1); // 하루씩 빼면서 7일 이전까지 날짜 생성
        }
       
        return labels;
    }
   
	// 차트 그리기-----------------------------------------------
    function updateChart(responseData) {
    	
    	const data = responseData.data;
    	
    	// labels에 현재 날짜부터 7일 전까지의 날짜 추가
        let labels = getLast7Days();
    	
    	// 들어오지 않은 데이터는 0으로 처리하기 위함
        let activeUsers = new Array(7).fill(0);
        let sessionDuration = new Array(7).fill(0);
        let newUsers = new Array(7).fill(0);
        let pageView = new Array(7).fill(0);
        data.forEach(function(d) {
        	let date = d.date;
			
        	// 현재~7일전까지의 날짜가 담긴 []와 현재날짜 일치하면 인덱스 반환
        	let labelIndex = labels.indexOf(date);
        	
        	if (labelIndex !== -1) {
                activeUsers[labelIndex] = d.activeuser;
                sessionDuration[labelIndex] = d.sessionduration / 60;
                newUsers[labelIndex] = d.newuser;
                pageView[labelIndex] = d.pageview;
            }
        });
       
            myChart.data.labels = labels;
            myChart.data.datasets[0].data = activeUsers;
            myChart.update();
           
            myChart2.data.labels = labels;
            myChart2.data.datasets[0].data = sessionDuration;
            myChart2.update();
            
            myChart3.data.labels = labels;
            myChart3.data.datasets[0].data = newUsers;
            myChart3.update();
            
            myChart4.data.labels = labels;
            myChart4.data.datasets[0].data = pageView;
            myChart4.update();
           
      
    }
     // 데이터 가져오기-------------------------------------------
     $.ajax({
         url: "/api_analytics",
         type: "GET",
         dataType: "json",
         success: function(response) {
             updateChart(response);
         },
         error: function(xhr, status, error) {
             console.error("데이터를 가져오는 데 실패했습니다:", status, error);
             alert("데이터를 가져오는 데 실패했습니다.");
         }
     });
});
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
			<h4>사이트 이벤트 통계</h4>
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
		<div class="member">
			<h4>회원관리 (총 ${list.size()} 명, 탈퇴 : ${blist.size()} 명)</h4>
			<table id="mem">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 17%;"/>
					<col style="width: 18%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 15%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>회원아이디</th>
					<th>이름</th>
					<th>생일</th>
					<th>휴대전화번호</th>
					<th>이메일</th>
					<th>성별</th>
					<th>이용약관</th>
					<th>개인정보처리방침</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="cnt" value="0"/>
				<c:forEach items="${ list}" var="mDto">
					<c:if test="${cnt < 6 }">
						<tr>
							<td>${mDto.id }</td>
							<td>${mDto.name}</td>
							<td><fmt:formatDate value="${mDto.birth }" pattern="yyyy-MM-dd"/></td>
							<td>${mDto.phone }</td>
							<td>${mDto.email }</td>
							<td>${mDto.gender }</td>
							<td>동의</td>
							<td>동의</td>
						</tr>
						<c:set var="cnt" value="${cnt +1 }"/>
					</c:if>
				</c:forEach>
				</tbody>
			</table>

			<button type="button" onclick="location.href='/admin/member'">회원 전체보기</button>
		</div>

		<!-- ----------------------------------------------------------------------------- -->
		<div class="petlist">
			<h4>반려동물관리 (총 ${plist.size()} 마리)</h4>
			<table id="pet">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 15%;"/>
					<col style="width: 10%;"/>
					<col style="width: 17%;"/>
					<col style="width: 10%;"/>
					<col style="width: 13%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>회원아이디</th>
					<th>반려동물 이름</th>
					<th>무게(kg)</th>
					<th>생일</th>
					<th>성별</th>
					<th>중성화여부</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="cnt" value="0" />
				<c:forEach items="${ plist}" var="pDto">
					<c:if test="${cnt < 6 }">
						<tr>
							<td>${pDto.id }</td>
							<td>${pDto.pname}</td>
							<td>${pDto.pweight }</td>
							<td><fmt:formatDate value="${pDto.pbirth }" pattern="yyyy-MM-dd"/></td>
							<td>${pDto.pgender }</td>
							<td>${pDto.psurgery }</td>
						</tr>
						<c:set var="cnt" value="${cnt +1 }"/>
					</c:if>
				</c:forEach>
				</tbody>
			</table>

			<button type="button" onclick="location.href='/admin/pet'">반려동물 전체보기</button>
		</div>
		<!-- ----------------------------------------------------------------------------- -->
		<div class="petlist">
			<h4>진단내역(happypet과 진단DB 조인)</h4>
			<table id="pet">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 17%;"/>
					<col style="width: 18%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 15%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>회원아이디</th>
					<th>이름</th>
					<th>생일</th>
					<th>휴대전화번호</th>
					<th>이메일</th>
					<th>성별</th>
					<th>이용약관</th>
					<th>개인정보처리방침</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="cnt" value="0"/>
				<c:forEach items="${ list}" var="mDto">
					<c:if test="${cnt < 2 }">
						<tr>
							<td>${mDto.id }</td>
							<td>${mDto.name}</td>
							<td><fmt:formatDate value="${mDto.birth }" pattern="yyyy-MM-dd"/></td>
							<td>${mDto.phone }</td>
							<td>${mDto.email }</td>
							<td>${mDto.gender }</td>
							<td>동의</td>
							<td>동의</td>
						</tr>
						<c:set var="cnt" value="${cnt +1 }"/>
					</c:if>
				</c:forEach>
				</tbody>
			</table>

			<button type="button" onclick="sBtn()">진단내역 전체보기</button>
		</div>
		<!-- ------------------------------------------------------------------------------------ -->
		<div class="boardlist">
			<h4>공지사항 게시판관리 (총 ${bclist.size()} 개의 글)</h4>
			<table id="board">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 20%;"/>
					<col style="width: 30%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>작성자ID</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>댓글수</th>
					<th>이동</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="cnt" value="0" />
				<c:forEach items="${ bclist}" var="bcDto">
					<c:if test="${cnt < 6 }">
						<tr>
							<td>${bcDto.id }</td>
							<td>${bcDto.btitle}</td>
							<td id ="content">${bcDto.bcontent }</td>
							<td>${bcDto.bdate }</td>
							<td>${bcDto.bhit }</td>
							<td>${bcDto.comment_cnt }</td>
							<td>기능불가</td>
						</tr>
						<c:set var="cnt" value="${cnt +1 }"/>
					</c:if>
				</c:forEach>
				</tbody>
			</table>

			<button type="button" onclick="location.href='/admin/board'">공지사항 전체보기</button>
		</div>

		<!-- ------------------------------------------------------------------------------------ -->
		<div class="qnalist">
			<h4>Q&A 게시판관리 (총 ${qalist.size()} 개의 글)</h4>
			<table id="qna">
				<colgroup>
					<col style="width: 10%;"/>
					<col style="width: 20%;"/>
					<col style="width: 30%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
					<col style="width: 10%;"/>
				</colgroup>
				<thead>
				<tr>
					<th>작성자ID</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>답변수</th>
					<th>이동</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="cnt" value="0" />
				<c:forEach items="${ qalist}" var="qaDto">
					<c:if test="${cnt < 10 }">
						<tr>
							<td>${qaDto.id }</td>
							<td>${qaDto.qtitle}</td>
							<td id ="content">${qaDto.qcontent }</td>
							<td>${qaDto.qdate }</td>
							<td>${qaDto.qhit }</td>
							<td>${qaDto.answer_cnt }</td>
							<td>기능불가</td>
						</tr>
						<c:set var="cnt" value="${cnt +1 }"/>
					</c:if>
				</c:forEach>
				</tbody>
			</table>

			<button type="button" onclick="location.href='/admin/qna'">Q&A 전체보기</button>
		</div>
		<!-- ------------------------------------------------------------------------------------ -->
	</div>
</section>
</body>
</html>