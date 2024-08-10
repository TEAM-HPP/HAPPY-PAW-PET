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
    <title>Happypawpet 입양후기</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gamja+Flower&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nanum+Gothic&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <link rel="stylesheet" href="/css/top.css">
    <link rel="stylesheet" href="/css/adoption/Cardlist.css">
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
	        <h1> 입양후기 </h1>
	        <div class="ad_title">
	        	HappyPawPet을 통해 입양하신 분들이라면 누구나 후기를 적어주세요!<br>
			    <span>	가족이 되어 즐겁게 지내시는 모습, 입양 전후 사진, 특이한 버릇, 입양 후 가장 좋은 점 등 입양을 망설이시거나 고민하시는 분들께 좋은 선물이 될 수 있습니다.</span>
        	</div>
	        <div class="wrapper">
	        	<form action="/adoption/Cardlist" name="review" method="post" enctype="multipart/form-data">
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
				<c:forEach items="${map.list}" var="bDto" varStatus="status">
		            <div class="card ${status.index % 4 == 0 ? 'start-row' : ''}">
		                <a href="/adoption/view?bno=${bDto.bno}&page=${map.page}&category=${map.category}&searchWord=${map.searchWord}" style=" height: 350px;">
		                    <div class="card-content">
		                        <div class="card-image-container">
		                            <c:choose>
		                                <c:when test="${not empty bDto.bfile}">
		                                    <img src="${pageContext.request.contextPath}/upload/${bDto.bfile}" alt="Happypawpet 입양후기사진" class="background">
		                                </c:when>
		                                <c:otherwise>
		                                    <img src="/image/default.jpg" alt="No Image" class="background">
		                                </c:otherwise>
		                            </c:choose>
                                    <img src="/image/greenpencil.png" alt="Overlay Image2" class="overlay2">
                                    <img src="/image/frame.png" alt="Overlay Image" class="overlay">
                                    <div class="text-overlay">
			                            <h2>
			                                ${bDto.btitle }
			                            </h2>
			                        </div>
		                        </div>
		                    </div>
		                </a>
	                    <div class="like">
	                    	<div class="off" onclick="onBtn(event,'${sessionId}',${bDto.bno})" style="display: ${likedBnoSet.contains(bDto.bno) ? 'none' : 'inline-block'};">
	                    		<p>${likeCountMap[bDto.bno]}</p><span><i class="fa-regular fa-heart" style="color: #000000;"></i></span>
	                    	</div>
	                    	<div class="on" onclick="offBtn(event,'${sessionId}',${bDto.bno})" style="display: ${likedBnoSet.contains(bDto.bno) ? 'inline-block' : 'none'};">
	                    		<p>${likeCountMap[bDto.bno]}</p><span><i class="fa-solid fa-heart" style="color: #ef4e4e;"></i></span>
	                    	</div>
	                    </div>
		            </div>
		        </c:forEach>
			</div>
	        <!-- ------------------------------------------------------------------------------------ -->
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
			    	<li class="prev"><a href="Cardlist?page=${map.page-1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			   
			    <c:forEach var="i" begin="${map.startPage }" end="${map.endPage }" step="1">
			    	<c:if test="${map.page == i}">
			    		<li class="myNum num"><div>${i}</div></li>
			    	</c:if>
			    	<c:if test="${map.page != i}">
			    	 	<li class="num"><a href="Cardlist?page=${i}&category=${map.category}&searchWord=${map.searchWord}">${i}</a></li>
			    	 </c:if>
			    </c:forEach>
			   
			    <!-- next 부분 -->
			    <c:if test="${map.page<map.maxPage}">
			    	<li class="next"><a href="Cardlist?page=${map.page+1}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="next"></li>
			    </c:if>
			   
			    <!-- last -->
		 		<c:if test="${map.page<map.maxPage}">
			    	<li class="last"><a href="Cardlist?page=${map.maxPage}&category=${map.category}&searchWord=${map.searchWord}"></a></li>
			    </c:if>
			    <c:if test="${map.page>=map.maxPage}">
			    	<li class="last"></li>
			    </c:if>
		    </ul>
	        <!-- ----------------------------------------------------------------- -->
	        <div id="blank"></div>
	        <c:choose>
	        	<c:when test="${sessionId == null }">
	        	</c:when>
	        	<c:otherwise>
	        		<c:choose>
	        			<c:when test="${sessionId == 'admin01' }">
	        				<div class="adminlist">
						        <div class="list"><a href="/adoption/notice">공지사항작성</a></div>
						        <div class="list"><a href="/adoption/adopt_writing">후기작성</a></div>
					        </div>
	        			</c:when>
	        			<c:otherwise>
	        				<div class="normallist">
					        	<div class="list"><a href="/adoption/adopt_writing">후기작성</a></div>
					        </div>
	        			</c:otherwise>
	        		</c:choose>
	        	</c:otherwise>
	        </c:choose>
	    </div>
	</section>
	<!-- ------------------------------------------------------------------ -->
	<%@ include file="../footer/footer.jsp" %>
</body>
</html>