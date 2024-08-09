<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="/css/top.css" />
		<link rel="stylesheet" type="text/css" href="/css/login/login.css" />
		<link rel="stylesheet" type="text/css" href="/css/footer.css" />
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	  	<script>
			$(function(){
				$(".sbtn").click(function(){
					var idChk = $("#saveCheckbox").is(":checked");
					var id = $("#id").val();
					var pw = $("#pw").val();
					
					//alert("로그인 진행");
					if(id == ""){
						alert("아이디를 입력하셔야 합니다.");
						$("#id").focus();
						return false;
					}else if(pw == ""){
						alert("패스워드를 입력하셔야 합니다.");
						$("#pw").focus();
						return false;
					}
					
					loginFrm.submit();
					
				});
			});
		</script>
		<script>
		    // 쿠키를 설정하는 함수
		    function setCookie(name, value, days) {
		        const d = new Date();
		        d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
		        let expires = "expires=" + d.toUTCString();
		        document.cookie = name + "=" + encodeURIComponent(value) + ";" + expires + ";path=/";
		    }
	
		    // 쿠키를 가져오는 함수
		    function getCookie(name) {
		        let nameEQ = name + "=";
		        let ca = document.cookie.split(';');
		        for (let i = 0; i < ca.length; i++) {
		            let c = ca[i];
		            while (c.charAt(0) === ' ') c = c.substring(1);
		            if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
		        }
		        return null;
		    }
	
		    // 쿠키를 삭제하는 함수
		    function deleteCookie(name) {
		        const d = new Date();
		        d.setTime(d.getTime() - 1);
		        let expires = "expires=" + d.toUTCString();
		        document.cookie = name + "=; " + expires + "; path=/";
		    }
	
		    // 로그인 폼 제출 시 쿠키 설정 및 삭제
		    document.addEventListener("DOMContentLoaded", function() {
		        // 로그인 폼이 제출될 때 호출되는 함수
		        document.getElementById("loginForm").addEventListener("submit", function(event) {
		            const remember = document.getElementById("saveCheckbox").checked;
		            const userId = document.getElementById("id").value;
		            
		            if (remember) {
		                setCookie("userId", userId, 1); // 1일 동안 쿠키 유지
		            } else {
		            	deleteCookie("userId");
		            }
		        });
		        
		        // 페이지 로드 시 쿠키 값 설정
		        const savedId = getCookie("userId");
		        if (savedId) {
		            document.getElementById("saveCheckbox").checked = true;
		            document.getElementById("id").value = savedId;
		        }
		    });
		    
		    // 페이지에서 쿠키 값 출력
		    function printCookies() {
		        let cookies = document.cookie.split(';');
		        cookies.forEach(cookie => {
		            let [name, value] = cookie.split('=');
		            console.log("쿠키 이름: " + name.trim() + " - 값: " + (value ? value.trim() : "없음"));
		        });
		    }
		</script>
		<title>HappyPawPet 로그인창</title>
	</head>
	<body id="loginPage">
		<%@ include file="../top/top.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
		<section>
			<div class="main">
				<h2>Login</h2>
				<form action="/login/login" name="loginFrm" id="loginForm" method="post">
					<div class="id">
						<input type="text" name="id" id="id" size="30" placeholder="아이디를 입력하세요.">
					</div>
					<div class="pw">
						<input type="password" name="pw" id="pw" size="45" placeholder="비밀번호 영문, 특수문자, 숫자혼합 8~12자">
					</div>
					<div id="save">
						<input type="checkbox" id="saveCheckbox" name="saveCheckbox" value="saveId">
						<label for="saveCheckbox">아이디 저장</label>
					</div>
					<div id="find">
						<a href="/login/findId"><span>아이디/비밀번호 찾기</span></a>
					</div>
					<button type="submit" class="sbtn">Login</button>
				</form>
			      <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=d6f5da98cfbe26c292397ddc4ff2a30b&redirect_uri=http://localhost:8181/kakao/oauth" class="kakao">
			      	<div id="kakaoBtn"><img src="/image/kakao_login.png"></div>
			      </a>
				<div class="sign-up-info">
					<h3>HappyPawPet의 회원이 아니신가요?</h3>
					<p>반려동물 건강관리를 한 곳에서! 우리 아이만을 생각한 특별하고 다양한 서비스가 있는 HappyPawPet에 지금바로 가입하세요! </p>
					<a href="/login/memberForm"><div class="sign-up">HappyPawPet 신규가입하기<div class="arrow">&emsp;</div></div></a>
				</div>
			</div>
		</section>
		<!-- ---------------------------------------------------------------------------- -->
		<%@ include file="../footer/footer.jsp" %>
	</body>
</html>