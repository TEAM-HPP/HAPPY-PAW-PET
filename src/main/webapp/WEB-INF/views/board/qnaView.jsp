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
  <title>Q&A view</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="/css/top.css">
  <link rel="stylesheet" href="/css/board/qnaView.css">
  <link rel="stylesheet" href="/css/footer.css">
  <script>
  	function deleteBtn(qno){
  		if(confirm("Qna를 삭제하시겠습니까?")){
  			location.href="/board/qnadelete?qno="+qno;
  			alert("삭제되었습니다.");
  		}
  	}
  	function updateBtn(qno){
  		if(confirm("Qna를 수정하시겠습니까?")){
  			location.href="/board/qnaUpdate?qno="+qno;
  		}
  	}
  </script>
</head>
<body id="qnaView">
	<%@ include file="../top/top.jsp" %>
	<!-- ----------------------------------------------------------------------------------- -->
	<section>
		<div id="blank"></div>
		<div id="main">
		    <h1>Q&A</h1>
		
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
		        <td><strong>${map.qnadto.qtitle }</strong></td>
		        <td id="bdate">날짜</td>
		        <td style="padding-left: 35px;"><fmt:formatDate value="${map.qnadto.qdate }" pattern="yyyy-MM-dd"/></td>
		        <td id="bhit">조회수</td>
		        <td style="padding-left: 70px; border-right: 2px black solid;">
		        	${map.qnadto.qhit }
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6" class="article">
			        <div style="text-align: left;">
				        ${map.qnadto.qcontent}
				    </div>
				    <br>
				    <c:if test="${map.qnadto.qfile != null}">
					    <div style="text-align: center;">
					        <img style="width: 20%;" src="/upload/${map.qnadto.qfile}">
					    </div>
					</c:if>
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6"><strong>다음글</strong> <span class="separator">|</span>
		        <c:if test="${map.nextDto.qno != null}">
		        	<a href="/board/qnaView?qno=${map.nextDto.qno }" id="nexttext">${map.nextDto.qtitle }</a>
		        </c:if>
		        <c:if test="${map.nextDto.qno == null}">
		        	다음 글이 없습니다.
		        </c:if>
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6"><strong>이전글</strong> <span class="separator">|</span>
		        <c:if test="${map.prevDto.qno != null}">
		        	<a href="/board/qnaView?qno=${map.prevDto.qno }" id="prevtext">${map.prevDto.qtitle }</a>
		        </c:if>
		        <c:if test="${map.prevDto.qno == null}">
		        	이전 글이 없습니다.
		        </c:if>
		        </td>
		      </tr>
		    </table>
		    <c:choose>
		    	<c:when test="${sessionId == 'admin01' }">
					<div class="allList">
					    <div class="list"><a href="#">삭제</a></div>
					    <div class="list"><a href="/board/answer?qno=${map.qnadto.qno }">답변하기</a></div>
				    	<div class="list"><a href="/board/qnaList">목록</a></div>
				    </div>
		    	</c:when>
		    	<c:otherwise>
		    		<c:choose>
		    			<c:when test="${sessionId == map.qnadto.id}">
							<div class="allList2">
							    <div class="list" onclick="deleteBtn(${map.qnadto.qno})"><a href="/board/qnaList">삭제</a></div>
							    <div class="list" onclick="updateBtn(${map.qnadto.qno})"><a href="/board/qnaUpdate?qno=${map.qnadto.qno }">수정</a></div>
							    <div class="list" onclick="window.history.back()"><a>목록</a></div>
						    </div>
						</c:when>
					    <c:otherwise>
							<div class="allList3">
						    	<div class="list"><a href="/board/qnaList">목록</a></div>
						    </div>
			            </c:otherwise>
		    		</c:choose>
		    	</c:otherwise>
			</c:choose>
			
			<!-- 답변 table -->
			
		    <c:if test="${alist.size() > 0 }">
		    	<c:set var="cnt" value="1"/>
		    	<c:forEach items="${alist }" var="aDto">
					<table id="qanswer">
					     <colgroup>
					        <col width="10%">
					        <col width="70%">
					        <col width="10%">
					        <col width="10%">
					      </colgroup>
					      <tr id="title">
					        <th style="padding-left: 50px;">답변&ensp;${cnt }</th>
					        <td style="border-top:none;border-bottom:none;"><strong></strong></td>
					        <td id="bdate">날짜</td>
					        <td style="padding-left: 35px;border-right: 2px black solid;">
					        	<fmt:formatDate value="${aDto.adate }" pattern="yyyy-MM-dd"/>
					        </td>
					      </tr>
					      <tr>
					        <td colspan="4" class="article" style="border-top: 2px solid black;">
						        ${aDto.acontent}
					        </td>
					      </tr>
				    </table>
				    <c:set var="cnt" value="${cnt +1 }"/>
			    </c:forEach>
		    </c:if>
		 </div>
	</section>
	<!-- --------------------------------------------------------------------------- -->
	<%@ include file="../footer/footer.jsp" %>
</body>
</html>