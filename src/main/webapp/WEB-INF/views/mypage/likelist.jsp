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
    <title>Happypawpet 좋아요게시글</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gamja+Flower&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nanum+Gothic&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <link rel="stylesheet" href="/css/top.css">
    <link rel="stylesheet" href="/css/mypage/likelist.css">
    <link rel="stylesheet" href="/css/footer.css">
    <script>
	    function onBtn(event,id,bno) {
	    	if(${sessionId != null}){
		    	console.log("id value:", id);
		    	console.log("bno value:", bno);
		    	const likeElement = $(event.target).closest('.like');
		        
		        likeElement.find('.off').css("display", "none");
		        likeElement.find('.on').css("display", "inline-block");
		        
		        $.ajax({
		            type: 'POST',
		            url: '/adoption/likeOn',
		            dataType: 'text',
		            data: { "id": id,"bno": bno },
		            success: function() { 
		            },
		            error: function(xhr, status, error) { 
		            }
		        });
	    		
	    	}else{
	    		alert("로그인 후 이용가능합니다.");
	    		return false;
	    	}
	    	
	    }
	
	    function offBtn(event,id,bno) {
	    	console.log("bno value:", bno);
	    	const likeElement = $(event.target).closest('.like');
	        
	        likeElement.find('.on').css("display", "none");
	        likeElement.find('.off').css("display", "inline-block");
	        
	        $.ajax({
	            type: 'POST',
	            url: '/adoption/likeOff',
	            dataType: 'text',
	            data: { "id": id,"bno": bno },
	            success: function() { 
	            },
	            error: function(xhr, status, error) { 
	            }
	        });
	    }
    </script>
</head>
<body>
	<%@ include file="../top/top.jsp" %>
	<!-- --------------------------------------------------------------------- -->
	<section>
		<div id="blank1"></div>
		<div id="main">
	        <h1> 내가 좋아요한 게시글 </h1>
	        <div class="ad_title">
	        	${sessionName }님이 좋아요를 누른 게시글을 한 번에 모아보세요!<br>
        	</div>
        	<div class="wrapper">
	        	<form action="/mypage/likelist" name="review" method="post" enctype="multipart/form-data">
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
	        <!-- ------------------------------------------------------------------------------------ -->
			<div class="card-container">
				<c:forEach items="${map.list}" var="bbDto" varStatus="status">
					<!-- 한 줄에 8개씩 3줄 => 한 페이지에 24개의 글 -->
		            <div class="card ${status.index % 8 == 0 ? 'start-row' : ''}">
		                <a href="/adoption/view?bno=${bbDto.bno}&page=${map.page}&category=${map.category}&searchWord=${map.searchWord}" style=" height: 350px;">
		                    <div class="card-content">
		                        <div class="card-image-container">
		                            <c:choose>
		                                <c:when test="${not empty bbDto.bfile}">
		                                    <img src="${pageContext.request.contextPath}/upload/${bbDto.bfile}" alt="Happypawpet 입양후기사진" class="background">
		                                </c:when>
		                                <c:otherwise>
		                                    <img src="/image/default.jpg" alt="No Image" class="background">
		                                </c:otherwise>
		                            </c:choose>
                                    <img src="/image/greenpencil.png" alt="Overlay Image2" class="overlay2">
                                    <img src="/image/frame.png" alt="Overlay Image" class="overlay">
                                    <div class="text-overlay">
			                            <h2>
			                                ${bbDto.btitle }
			                            </h2>
			                        </div>
		                        </div>
		                    </div>
		                </a>
		            </div>
		        </c:forEach>
			</div>
	        <!-- ------------------------------------------------------------------------------------ -->
	        <ul class="page-num">
			    <!-- first -->
			    <c:if test="${map.page>map.startPage}">
			    	<li class="first"><a href="likelist?page=${map.startPage}"></a></li>
			    </c:if>
			    <c:if test="${map.page==map.startPage}">
			    	<li class="first"></li>
			    </c:if>
			   
			    <!-- prev -->
			    <c:if test = "${map.page<=1 }">
			      <li class="prev"></li>
			    </c:if>
			    <c:if test = "${map.page>1 }">
			    	<li class="prev"><a href="likelist?page=${map.page-1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			   
			    <c:forEach var="i" begin="${map.startPage }" end="${map.endPage }" step="1">
			    	<c:if test="${map.page == i}">
			    		<li class="myNum num"><div>${i}</div></li>
			    	</c:if>
			    	<c:if test="${map.page != i}">
			    	 	<li class="num"><a href="likelist?page=${i}">${i}</a></li>
			    	 </c:if>
			    </c:forEach>
			   
			    <!-- next 부분 -->
			    <c:if test="${map.page<map.maxPage}">
			    	<li class="next"><a href="likelist?page=${map.page+1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="next"></li>
			    </c:if>
			   
			    <!-- last -->
		 		<c:if test="${map.page<map.maxPage}">
			    	<li class="last"><a href="likelist?page=${map.maxPage}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="last"></li>
			    </c:if>
		    </ul>
	        <!-- ----------------------------------------------------------------- -->
	        <div id="blank"></div>
	    </div>
	</section>
	<!-- ------------------------------------------------------------------ -->
	<%@ include file="../footer/footer.jsp" %>
</body>
</html>