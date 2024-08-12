<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    
<header>
		<nav>
			<div id="logo">
				<a href="/index">
				HappyPawPet<div id="logoImg"></div>
				</a>
			</div>
		<script>
			function pBtn(){
				if (${sessionId == null}){
					$("#q06").css("display","inline-block");
					$("#q07").css("display","none");
					alert("로그인 이후 이용 가능한 페이지입니다.");
					location.href="/login/login";
				}else{
					$("#q06").css("display","none");
					$("#q07").css("display","inline-block");
				}
				
			}
			
			
			function checkBtn(){
				if (${sessionId == null}){
					alert("로그인 이후 이용 가능한 페이지입니다.");
					location.href="/login/login";
				}else{
					location.href="/diagnosis/CheckTool";
				}
			}
			
			 $(document).ready(function(){

					$('.submenu').hide();
					$('.submenuA').hide();

					$('#q088').mouseover(function(){
						$('.submenu').slideDown();

					});
					$('.qmenu').mouseleave(function(){
						$('.submenu').hide();
						$('.submenuA').hide();
					});
					
					$('#q044').mouseover(function(){
						$('.submenuA').slideDown();
					});
				});
		</script>
		<div id="navi">
				<div class="qmenu">
					<ul class="title">
						<li class="titlesub"><a href="/index" class="titlesublink" id="q01">Home</a></li>
						<li class="titlesub" id="q088">
							<a href="/board/list" class="titlesublink" id="q08">게시판</a>
							<ul class="submenu">
								<li><a href="/board/list" class="submenulink">공지사항</a></li>
								<li><a href="/board/qnaList" class="submenulink">Q&A</a></li>
							</ul>
						</li>
						<li class="titlesub"><a href="#" class="titlesublink" id="q02" onclick="checkBtn()">CheckTools</a></li>
						<li class="titlesub"><a href="/emergency/emergency" class="titlesublink" id="q03">Emergency</a></li>
						<li class="titlesub" id="q044">
							<a href="/adoption/animalList" class="titlesublink" id="q04">Adoption</a>
							<ul class="submenuA">
								<li><a href="/adoption/animalList" class="submenulink">입양공고</a></li>
								<li><a href="/adoption/Cardlist" class="submenulink">커뮤니티</a></li>
							</ul>
						</li>
						<c:choose>
						    <c:when test="${sessionId == null}">
						        <li class="titlesub"><a href="/login/login" class="titlesublink" id="q05">Login</a></li>
						        <li class="titlesub"><a href="#" class="titlesublink" id="q06" onclick="pBtn()">MyPage</a></li>
						    </c:when>
						    <c:when test="${sessionId != null}">
						        <li class="titlesub"><a href="/kakao/logout" class="titlesublink" id="q05">Logout</a></li>
						        <c:choose>
						            <c:when test="${sessionId == 'admin01'}">
						                <li class="titlesub"><a href="/admin/admin" class="titlesublink" id="q07" onclick="pBtn()">관리자페이지로 이동</a></li>
						            </c:when>
						            <c:otherwise>
						                <li class="titlesub"><a href="/mypage/myPage" class="titlesublink" id="q07" onclick="pBtn()">${sessionName} 님의 MyPage</a></li>
						            </c:otherwise>
						        </c:choose>
						    </c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
</header>