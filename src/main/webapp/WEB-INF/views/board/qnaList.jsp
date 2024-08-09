<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>HappyPawPet Q&A</title>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
	<link rel="stylesheet" href="/css/top.css">
	<link rel="stylesheet" href="/css/board/qnaList.css">
	<link rel="stylesheet" href="/css/footer.css">
</head>
<body>
	<%@ include file="../top/top.jsp" %>
	<!-- -------------------------------------------------------- -->
	<script>
		//질문하기
		 function wBtn(){
			 location.href="/board/question";
			 }
	</script>
	<script>
		//검색하기
	  	function sBtn(){
	  		search.submit();
	  	}
  	</script>
  	<script>
  		//로그인X -> myQna, 질문하기 버튼 안보임
  		$(document).ready(function(){
	  		if (${sessionId == null}) {
	  			$("#myQna").css("display","none");
	  			$(".write").css("display","none");
	  		}
	  		else {
	  			$("#myQna").css("display","inline-block");
	  			$(".write").css("display","inline-block");
	  		}
  	 	});
  	</script>
  	<script>
		//MyQnA 검색
	  	function myBtn(){
			location.href="/board/qnaList?qna=1";
	  	}
  </script>
	<section>
		<div id="blank1"></div>
		<div class="main">
			<div class="subbanner"></div>
		    <h1>Q&A</h1>
		    <div class="wrapper">
		      <form action="/board/qnaList" name="search" method="post">
		        <select name="category" id="category">
		          <option value="all">전체</option>
		          <option value="qtitle">제목</option>
		          <option value="qcontent">내용</option>
		        </select>
		
		        <div class="title">
		          <input type="text" size="16" name="searchWord" id="searchWord" value="${map.searchWord }">
		        </div>
		        <button type="button" onclick="sBtn()"><i class="fas fa-search"></i></button>
		      </form>
		        <button type="button" class="myQna" id="myQna" onclick="myBtn()">My QnA</button>
		    </div>
		    <table>
		      <colgroup>
		        <col width="18%">
		        <col width="40%">
		        <col width="18%">
		        <col width="10%">
		        <col width="10%">
		      </colgroup>
		      <!-- 제목부분 -->
		      <tr>
		        <th>No.</th>
		        <th>제목</th>
		        <th>작성일</th>
		        <th>답변상태</th>
		        <th>조회수</th>
		      </tr>
		      <!-- 내용부분 -->
		      <c:forEach items="${map.list }" var="qDto">
			      <tr>
			        <td><span class="table-notice">${qDto.qno}</span></td>
			        <td class="table-title">
			        <a href="/board/qnaView?qno=${qDto.qno }&page=${map.page}&category=${map.category}&searchWord=${map.searchWord}&qna=${map.qna}&id=${map.id}">${ qDto.qtitle}</a>
			        </td>
			        <td><fmt:formatDate value="${qDto.qdate }" pattern="yyyy-MM-dd"/></td>
			        <c:if test="${qDto.qanswer =='미완료'}">
				        <td><span id="anwser" style="background-color: #EDDDE0;">${qDto.qanswer }</span></td>
			        </c:if>
			        <c:if test="${qDto.qanswer =='답변완료'}">
				        <td><span id="anwser">${qDto.qanswer }</span></td>
			        </c:if>
			        <td>${qDto.qhit }</td>
			      </tr>
		      </c:forEach>
		    
		    </table>
		    <ul class="page-num">
		  
		    <!-- first -->
		    <c:if test="${map.page>1}">
		    	<a href="qnaList?page=${map.startPage}"><li class="first"></li></a>
		    </c:if>

		    <c:if test="${map.page<=1}">
		    	<li class="first"></li>
		    </c:if>
		   
		    <!-- prev -->
		    <c:if test = "${map.page<=1 }">
		      <li class="prev"></li>
		    </c:if>
		    <c:if test = "${map.page>1 }">
		    	<a href="qnaList?page=${map.page-1}&category=${map.category}&searchWord=${map.searchWord}&qna=${map.qna}&id=${map.id}"><li class="prev"></li></a>
		    </c:if>
		   
		    <c:forEach var="i" begin="${map.startPage }" end="${map.endPage }" step="1">
		    	<c:if test="${map.page == i}">
		    		<li class="MyNum num"><div>${i}</div></li>
		    	</c:if>
		    	<c:if test="${map.page != i}">
		    	 	<a href="qnaList?page=${i}&category=${map.category}&searchWord=${map.searchWord}&qna=${map.qna}&id=${map.id}"><li class="num"><div>${i}</div></li></a>
		    	 </c:if>
		    </c:forEach>
		   
		    <!-- next 부분 -->
		    <c:if test="${map.page<map.maxPage}">
		    	<a href="qnaList?page=${map.page+1}&category=${map.category}&searchWord=${map.searchWord}&qna=${map.qna}&id=${map.id}"><li class="next"></li></a>
		    </c:if>
		    <c:if test="${map.page>=map.maxPage}">
		    	<li class="next"></li>
		    </c:if>
		   
		    <!-- last -->
	 		<c:if test="${map.page<map.maxPage}">
		    	<a href="qnaList?page=${map.maxPage}&category=${map.category}&searchWord=${map.searchWord}&qna=${map.qna}&id=${map.id}"><li class="last"></li></a>
		    </c:if>
		    <c:if test="${map.page>=map.maxPage}">
		    	<li class="last"></li>
		    </c:if>
		    </ul>
			<div id="blank"></div>
	    	<div class="write"><a href="#" onclick="wBtn()">질문하기</a></div>
    	</div>
	  </section>
	 
	  <%@ include file="../footer/footer.jsp" %>
</body>
</html>