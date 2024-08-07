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