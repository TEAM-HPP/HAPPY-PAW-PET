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
	<link rel="stylesheet" type="text/css" href="/css/admin/adminBoard.css" />
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
				<h2><span>게시판 관리</span></h2>
				<div class="boardlist">
					<div id="comment">
					<h4>공지사항 게시판관리 (총 ${bclist.size()} 개의 글)</h4>
					<button id="Kanalyst" class="Total" onclick="location.href='/admin/boardDetail'">공지사항관리이동</button>
					</div>
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
								<c:if test="${cnt < 5 }">
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
				<div class="qnalist">
					<div id="comment2">
						<h4>Q&A 관리 (총 ${qalist.size()} 개의 글)</h4>
						<button id="Kanalyst" class="Total" onclick="location.href='/admin/qna'">QNA관리이동</button>
					</div>
					<table id="board2">
						<colgroup> 
					    	<col style="width: 7%;"/> 
					        <col style="width: 25%;"/> 
					        <col style="width: 28%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					    </colgroup> 
					    <thead>
							<tr>
								<th>게시글번호</th>
								<th>제목</th>
								<th>내용</th>
								<th>작성일자</th>
								<th>조회수</th>
								<th>답변수</th>
								<th>이동</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="cnt" value="0"/>
							<c:forEach items="${ qalist}" var="qaDto">
								<c:if test="${cnt < 5 }">
								<tr>
									<td id="qno">${qaDto.qno }</td>
									<td>${qaDto.qtitle}</td>
									<td id ="content">${qaDto.qcontent }</td>
									<td>${qaDto.qdate }</td>
									<td>${qaDto.qhit }</td>
									<td>${qaDto.answer_cnt }</td>
									<td id="button"><div id="QnaOne"><a href="/board/qnaView?qno=${qaDto.qno }">바로가기</a></div></td>
								</tr>
								<c:set var="cnt" value="${cnt +1 }"/>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- -------------------------------------------------------------------------------------------------- -->
				<div class="qnalist">
					<div id="comment3">
						<h4>입양공고 커뮤니티 관리 (총 ${adlist.size()} 개의 글)</h4>
						<button id="Kanalyst" class="Total" onclick="location.href='/admin/adoption'">커뮤니티관리이동</button>
					</div>
					<table id="board2">
						<colgroup> 
					    	<col style="width: 7%;"/> 
					        <col style="width: 25%;"/> 
					        <col style="width: 28%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					        <col style="width: 10%;"/> 
					    </colgroup> 
					    <thead>
							<tr>
								<th>게시글번호</th>
								<th>제목</th>
								<th>내용</th>
								<th>작성일자</th>
								<th>조회수</th>
								<th>답글수</th>
								<th>이동</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="cnt" value="0"/>
							<c:forEach items="${ adlist}" var="adDto">
								<c:if test="${cnt < 5 }">
								<tr>
									<td id="qno">${adDto.bno }</td>
									<td>${adDto.btitle}</td>
									<td id ="content">${adDto.bcontent }</td>
									<td>${adDto.bdate }</td>
									<td>${adDto.bhit }</td>
									<td>${adDto.bindent }</td>
									<td id="button"><div id="QnaOne"><a href="/adoption/view?bno=${adDto.bno }">바로가기</a></div></td>
								</tr>
								<c:set var="cnt" value="${cnt +1 }"/>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- -------------------------------------------------------------------------------------------------- -->
			</div>
		</section>
	</body>
</html>