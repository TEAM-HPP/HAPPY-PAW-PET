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
	<link rel="stylesheet" type="text/css" href="/css/admin/adminBoardDetail.css" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>HappyPawPet 관리자페이지</title>
	</head>
	<body id="admin">
		<%@ include file="../top/adminTop.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
		<section>
			<%@ include file="../admin/subbanner.jsp" %>
			<div class="main">
				<h2><span>공지사항 관리</span></h2>
				<div class="boardlist">
					<h4>공지사항 조회수 Top 10</h4>
					<table id="board">
						<colgroup> 
					    	<col style="width: 5%;"/> 
					        <col style="width: 25%;"/> 
					        <col style="width: 30%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					    </colgroup> 
					    <thead>
							<tr>
								<th>순위</th>
								<th>제목</th>
								<th>내용</th>
								<th>작성일자</th>
								<th>조회수</th>
								<th>댓글수</th>
								<th>이동</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="rank" value="1"/>
							<c:forEach items="${ rlist}" var="rDto">
									<c:if test="${rank < 11 }">
									<tr>
										<td id="rank">${rank }</td>
										<td>${rDto.btitle}</td>
										<td id ="content">${rDto.bcontent }</td>
										<td>${rDto.bdate }</td>
										<td>${rDto.bhit }</td>
										<td>${rDto.comment_cnt }</td>
										<td id="button"><div id="boardOne"><a href="/board/view?bno=${rDto.bno }">바로가기</a></div></td>
									</tr>
									<c:set var="rank" value="${rank +1 }"/>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- ------------------------------------------------------------------ -->
				<div class="boardlist">
					<div id="comment">
						<h4>공지사항 댓글수 Top 10</h4>
						<button id="Canalyst" onclick="location.href='/admin/boardComment'">댓글 분석하기</button>
					</div>
					<table id="board">
						<colgroup> 
					    	<col style="width: 5%;"/> 
					        <col style="width: 25%;"/> 
					        <col style="width: 30%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					    </colgroup> 
					    <thead>
							<tr>
								<th>순위</th>
								<th>제목</th>
								<th>내용</th>
								<th>작성일자</th>
								<th>조회수</th>
								<th>댓글수</th>
								<th>이동</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="rank" value="1"/>
							<c:forEach items="${ clist}" var="cDto">
									<c:if test="${rank < 11 }">
									<tr>
										<td id="rank">${rank }</td>
										<td>${cDto.btitle}</td>
										<td id ="content">${cDto.bcontent }</td>
										<td>${cDto.bdate }</td>
										<td>${cDto.bhit }</td>
										<td>${cDto.comment_cnt }</td>
										<td id="button"><div id="boardOne"><a href="/board/view?bno=${cDto.bno }">바로가기</a></div></td>
									</tr>
									<c:set var="rank" value="${rank +1 }"/>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- -------------------------------------------------------------- -->
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
							<c:set var="cnt" value="0"/>
							<c:forEach items="${ bclist}" var="bcDto">
								<c:if test="${cnt < 10 }">
									<tr>
										<td>${bcDto.id }</td>
										<td>${bcDto.btitle}</td>
										<td id ="content">${bcDto.bcontent }</td>
										<td>${bcDto.bdate }</td>
										<td>${bcDto.bhit }</td>
										<td>${bcDto.comment_cnt }</td>
										<td id="button"><div id="boardOne"><a href="/board/view?bno=${bcDto.bno }">바로가기</a></div></td>
									</tr>
									<c:set var="cnt" value="${cnt +1 }"/>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- ------------------------------------------------------------------------ -->
			</div>
		</section>
	</body>
</html>