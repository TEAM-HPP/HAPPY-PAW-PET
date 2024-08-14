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
  <title>HappyPawPet 공지사항</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="/css/top.css">
  <link rel="stylesheet" href="/css/board/list.css">
  <link rel="stylesheet" href="/css/footer.css">
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script>
	  function wBtn(){
			if (${sessionId == 'admin01'}){
				$(".write").css("display","block");
				location.href="/board/write";
			}else{
				$(".write").css("display","none");
			}
			
		}
 </script>
 <script>
	//검색하기
  	function sBtn(){
  		search.submit();
  	}
</script>
</head>
<body id="list">
	<%@ include file="../top/top.jsp" %>
	<!-- -------------------------------------------------------- -->
	<section>
		<div id="blank1"></div>
		<div id="main">
			<div class="subbanner"></div>
		    <h1>NOTICE</h1>
		    <div class="wrapper">
		      <form action="/board/list" name="search" method="post">
		        <select name="category" id="category">
		          <option value="all">전체</option>
		          <option value="btitle">제목</option>
		          <option value="bcontent">내용</option>
		        </select>
		
		        <div class="title">
		          <input type="text" size="16" name="searchWord" id="searchWord" value="${map.searchWord }">
		        </div>
		  
		        <button type="submit" onclick="sBtn()"><i class="fas fa-search"></i></button>
		      </form>
		    </div>
		
		    <table>
		      <colgroup>
		        <col width="18%">
		        <col width="50%">
		        <col width="18%">
		        <col width="10%">
		      </colgroup>
		      <!-- 제목부분 -->
		      <tr>
		        <th>No.</th>
		        <th>제목</th>
		        <th>작성일</th>
		        <th>조회수</th>
		      </tr>
		      <!-- 내용부분 -->
		      <c:forEach items="${map.list }" var="bDto">
			      <tr>
			      	<c:choose>
				      	<c:when test="${bDto.topchk == 2 }">
				        	<td><span class="table-Must">필독</span></td>
				        </c:when>
				      	<c:when test="${bDto.topchk == 1 }">
				        	<td><span class="table-notice">공지</span></td>
				        </c:when>
				        <c:otherwise>
				        	<td><span class="table-normal">${bDto.bno }</span></td>
				        </c:otherwise>
			        </c:choose>
			        <td class="table-title">
			        <a href="/board/view?bno=${bDto.bno }">${ bDto.btitle}</a>
			        </td>
			        <td><fmt:formatDate value="${bDto.bdate }" pattern="yyyy-MM-dd"/></td>
			        <td>${bDto.bhit }</td>
			      </tr>
		      </c:forEach>
		    </table>
			<!-- ----------------------------------------------------------- -->
		    <ul class="page-num">
			    <!-- first -->
			    <c:if test="${map.page>map.startPage}">
			    	<li class="first"><a href="list?page=${map.startPage}"></a></li>
			    </c:if>
			    <c:if test="${map.page==map.startPage}">
			    	<li class="first"></li>
			    </c:if>
			   
			    <!-- prev -->
			    <c:if test = "${map.page<=1 }">
			      <li class="prev"></li>
			    </c:if>
			    <c:if test = "${map.page>1 }">
			    	<li class="prev"><a href="list?page=${map.page-1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			   
			    <c:forEach var="i" begin="${map.startPage }" end="${map.endPage }" step="1">
			    	<c:if test="${map.page == i}">
			    		<li class="myNum num"><div>${i}</div></li>
			    	</c:if>
			    	<c:if test="${map.page != i}">
			    	 	<li class="num"><a href="list?page=${i}&category=${map.category}&searchWord=${map.searchWord}">${i}</a></li>
			    	 </c:if>
			    </c:forEach>
			   
			    <!-- next 부분 -->
			    <c:if test="${map.page<map.maxPage}">
			    	<li class="next"><a href="list?page=${map.page+1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="next"></li>
			    </c:if>
			   
			    <!-- last -->
		 		<c:if test="${map.page<map.maxPage}">
			    	<li class="last"><a href="list?page=${map.maxPage}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="last"></li>
			    </c:if>
		    </ul>
		    <!-- ----------------------------------------------------------- -->
			<div id="blank"></div>
			<c:if test="${sessionId == 'admin01'}">
		    	<div class="write"><a href="/board/write" onclick="wBtn">쓰기</a></div>
			</c:if>
		</div>
	 </section>
	 <!-- ----------------------------------------------------------------- -->
	 <%@ include file="../footer/footer.jsp" %>
</body>
</html>