<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>NOTICE view</title>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
	<link rel="stylesheet" href="/css/top.css">
	<link rel="stylesheet" href="/css/board/view.css">
	<link rel="stylesheet" href="/css/footer.css">
	<script>
		function deleteBtn(bno){
			if(confirm("게시글을 삭제하시겠습니까?")){
				location.href="/board/boardDelete?bno="+bno;
				alert("삭제되었습니다.");
			}
		}
		function updateBtn(bno){
			if(confirm("게시글을 수정하시겠습니까?")){
				location.href="/board/boardUpdate?bno="+bno;
			}
		}
	</script>
</head>
<body id="qnaView">
<%@ include file="../top/top.jsp" %>
<!-- ------------------------------------------------------------------------------------- -->

<section>
	<div id="blank"></div>
	<div id="main">
		<h1>NOTICE</h1>

		<table>
			<colgroup>
				<col width="10%">
				<col width="50%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr id="title">
				<th style="padding-left: 60px;">제목</th>
				<td><strong>${map.bDto.btitle }</strong></td>
				<td id="bdate">작성날짜</td>
				<td style="padding-left: 35px;"><fmt:formatDate value="${map.bDto.bdate }" pattern="yyyy-MM-dd"/></td>
				<td id="bhit">조회수</td>
				<td style="padding-left: 70px; border-right: 2px black solid;">
					${map.bDto.bhit }
				</td>
			</tr>
			<tr>
				<td colspan="6" class="article">
					<div style="text-align: left;">
						${map.bDto.bcontent}
					</div>
					<br>
					<c:if test="${map.bDto.bfile != null}">
						<div style="text-align: center;">
							<img style="width: 20%;" src="/upload/${map.bDto.bfile}">
						</div>
					</c:if>
				</td>
			</tr>
			<!--이전글 & 다음글 ----------------------------------------------------------------- -->
			<tr>
				<td colspan="6"><strong>다음글</strong> <span class="separator">|</span>
					<c:if test="${map.nextDto.bno != null}">
						<a href="/board/view?bno=${map.nextDto.bno }&page=${page}" id="text">[게시글]${map.nextDto.btitle }</a>
					</c:if>
					<c:if test="${map.nextDto.bno == null}">
						다음 글이 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="6"><strong>이전글</strong> <span class="separator">|</span>
					<c:if test="${map.prevDto.bno != null}">
						<a href="/board/view?bno=${map.prevDto.bno }&page=${page}" id="text">[게시글]${map.prevDto.btitle }</a>
					</c:if>
					<c:if test="${map.prevDto.bno == null}">
						이전 글이 없습니다.
					</c:if>
				</td>
			</tr>
		</table>
		<c:choose>
			<c:when test="${sessionId == 'admin01'}">
				<div class="allList">
					<div class="list" onclick="deleteBtn(${map.bDto.bno})"><a href="#">삭제</a></div>
					<div class="list" onclick="updateBtn(${map.bDto.bno})"><a href="#">수정</a></div>
					<div class="list"><a href="/board/list?page=${page}&category=${category}&searchWord=${searchWord}">목록</a></div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="allList2">
					<div class="list"><a href="/board/list?page=${page}&category=${category}&searchWord=${searchWord}">목록</a></div>
				</div>
			</c:otherwise>
		</c:choose>
		<!-- --------------------------------------------------------------------------------------- -->
		<div class="writeReply">
			<c:if test="${sessionId !=null }">
				<form action="/board/writeReply" name="rFrm" id="rFrm" method="post">
					<input type="hidden" name="id" value="${sessionId }">
					<input type="hidden" name="bno" value="${map.bDto.bno }">
					<input type="text" name="ccontent" required>
					<button type="submit" id="send">작성완료</button>
				</form>
			</c:if>
			<!-- 댓글 개수 체크-->
			<c:choose>
				<c:when test="${clist.size() == 0 }">
					<div id="replycnt" style="margin-bottom: 50px;">
						<span>등록된 댓글이 없습니다.</span>
					</div>
				</c:when>
				<c:otherwise>
					<div id="replycnt">
						<span>댓글&ensp;${clist.size()}</span>
					</div>
				</c:otherwise>
			</c:choose>
			<!-- -------------------------------------------------------------------------------------------- -->
			<script>
				function cdBtn() {
					if (confirm("댓글을 삭제하시겠습니까?")) {
						var deleteC = document.forms["deleteC"];
						if (deleteC) {
							deleteC.submit();
							alert("댓글이 삭제되었습니다.");
						} else {
							console.error('폼 요소를 찾을 수 없습니다.');
						}
					} else {
						return false;
					}
				}
			</script>
			<!-- -------------------------------------------------------------------------------------------- -->
			<script>
				document.addEventListener("DOMContentLoaded", function() {
					// 모든 닉네임 요소를 선택
					var nickname = document.querySelectorAll("#nickname span");

					nickname.forEach(function(nickname) {
						var userId = nickname.textContent;

						// 맨 뒤에서 3글자를 ***로 처리
						var processedId = userId.slice(0, -3) + "***";
						nickname.textContent = processedId;

					});
				});
			</script>
			<!-- 답글 부분 반복-->
			<table id="reply">
				<c:if test="${clist.size() > 0 }">
					<c:forEach items="${clist }" var="cDto">
						<tr id="title2">
							<td style="border-bottom : none; border-top : none;">
								<div id="nickname"><span>${cDto.id}</span></div>
								<c:if test="${cDto.id == sessionId }">
									<form action = "/board/deleteComment" name="deleteC" method="post">
										<input type="hidden" name="cno" value="${cDto.cno }">
										<input type="hidden" name="bno" value="${cDto.bno }">
										<input type="hidden" name="id" value="${cDto.id }">
										<div class="replyList">
											<button type="button" onclick="cdBtn()">삭제</button>
										</div>
									</form>
								</c:if>
							</td>
						</tr>
						<tr>
							<td style="border-top : none;">
								<div id="content">${cDto.ccontent }</div>
								<div id="cdate">${cDto.cdate }</div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<!-- 답글부분 -->
	</div>
</section>
<!-- --------------------------------------------------------------------------- -->
<%@ include file="../footer/footer.jsp" %>
</body>
</html>