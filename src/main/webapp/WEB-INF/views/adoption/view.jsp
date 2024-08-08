
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>뷰페이지</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="/css/top.css">
  <link rel="stylesheet" href="/css/adoption/view.css">
  <link rel="stylesheet" href="/css/footer.css">
  <script>
    function deleteBtn(bno){
    	//alert(bno);
    	if(confirm("게시글을 삭제하시겠습니까?")){
    		location.href="/adoption/delete?bno="+bno;
    	}
    }
    
    function updateBtn(bno){
    	//alert(bno);
    	if(confirm("게시글을 수정하시겠습니까?")){
    		location.href="/adoption/update?bno="+bno;
    	}
    }
    
  </script>
</head>
<body id="qnaView">
	<%@ include file="../top/top.jsp" %>
	<!-- --------------------------------------------------------------------- -->
	<section>
		<div id="blank"></div>
		<div id="main">
		    <h1>입양후기</h1>
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
		        <td><strong>${map.adoptDto.btitle }</strong></td>
		        <td id="bdate">작성날짜</td>
		        <td style="padding-left: 35px;">${map.adoptDto.bdate }</td>
		        <td id="bhit">조회수</td>
		        <td style="padding-left: 70px; border-right: 2px black solid;">
		        	${map.adoptDto.bhit }
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6" class="article">
			        <div style="text-align: left;">
				        ${map.adoptDto.bcontent}
				    </div>
				    <br>
				    <c:if test="${map.adoptDto.bfile != null}">
					    <div style="text-align: center;">
					        <img style="width: 20%;" src="/upload/${map.adoptDto.bfile}">
					    </div>
					</c:if>
		        </td>
		      </tr>
		      <!--이전글 & 다음글 ----------------------------------------------------------------- -->
		      <tr>
		        <td colspan="6"><strong>다음글</strong> <span class="separator">|</span> 
		        	<c:if test="${map.prevDto.bno != null }">
		        		<a href="/adoption/view?bno=${map.prevDto.bno}&page=${page}" id="text22">[게시글] ${map.prevDto.btitle }</a> 
		        	</c:if>
		        	<c:if test="${map.prevDto.bno == null }">
		        		다음글이 없습니다.
		        	</c:if>
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6"><strong>이전글</strong> <span class="separator">|</span> 
		        	<c:if test="${map.nextDto.bno != null }">
		        	  <a href="/adoption/view?bno=${map.nextDto.bno}&page=${page}" id="text22">[게시글] ${map.nextDto.btitle }</a>
		        	</c:if>
		        	<c:if test="${map.nextDto.bno == null }">
		        		이전글이 없습니다.
		        	</c:if>
		        </td>
		      </tr>
		    </table>
		    <c:choose>
		    	<c:when test="${sessionId == map.adoptDto.id }">
		    		<div class="allList">
					    <div class="list" onclick="deleteBtn(${map.adoptDto.bno})"><a href="#">삭제</a></div>
					    <div class="list" onclick="updateBtn(${map.adoptDto.bno})"><a href="#">수정</a></div>
					    <div class="list"><a href="/adoption/reply?bno=${map.adoptDto.bno }">답변달기</a></div>
					    <div class="list"><a href="/adoption/adopt_review?page=${page}&category=${category}&searchWord=${searchWord}">목록</a></div>
		    		</div>
		    	</c:when>
		    	<c:otherwise>
		    		<div class="allList2">
					    <div class="list"><a href="/adoption/reply?bno=${map.adoptDto.bno }">답변달기</a></div>
					    <div class="list"><a href="/adoption/adopt_review?page=${page}&category=${category}&searchWord=${searchWord}">목록</a></div>
		    		</div>
		    	</c:otherwise>
		    </c:choose>
		</div>	 
	</section>
	<!-- -------------------------------------------------------------------- -->
	<%@ include file="../footer/footer.jsp" %>
</body>
</html>
