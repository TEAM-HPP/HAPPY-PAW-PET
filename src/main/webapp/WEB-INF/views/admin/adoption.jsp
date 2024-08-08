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
	<link rel="stylesheet" type="text/css" href="/css/admin/adminAdoption.css" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>HappyPawPet 관리자페이지</title>
	</head>
	<body id="admin">
		<%@ include file="../top/adminTop.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
		<%@ include file="../admin/subbanner.jsp" %>
		<section>
			<%@ include file="../admin/subbanner.jsp" %>
			<div class="main">
				<h2><span>입양공고 커뮤니티 관리</span></h2>
				<div class="boardlist">
					<h4>커뮤니티 리스트 (총 ${adlist.size() }개의 글)</h4>
					<table id="board">
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
							<c:forEach items="${ adlist}" var="adDto">
								<tr>
									<td id="qno">${adDto.bno }</td>
									<td>${adDto.btitle}</td>
									<td id ="content">${adDto.bcontent }</td>
									<td>${adDto.bdate }</td>
									<td>${adDto.bhit }</td>
									<td>${adDto.bindent }</td>
									<td id="button"><div id="ComOne"><a href="/adoption/view?bno=${adDto.bno }">바로가기</a></div></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- ----------------------------------------------------------------------------- -->
			</div>
		</section>
	</body>
</html>