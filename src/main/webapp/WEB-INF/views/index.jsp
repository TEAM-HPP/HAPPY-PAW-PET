<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		<link rel="stylesheet" type="text/css" href="/css/top.css" />
		<link rel="stylesheet" type="text/css" href="/css/index.css" />
		<link rel="stylesheet" type="text/css" href="/css/footer.css" />
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<title>HappyPawPet</title>
	</head>
	<!--  ---------------------------------------------------------------------------->
	<body >
		<%@ include file="top/top.jsp" %>
		<!--  ---------------------------------------------------------------------------->
		<section>
			<div id="banner">
				<div id="set">
					<div class="title">
						<p>반려동물의 건강을</p>
						<p>최우선으로 생각하는</p>
						<p>헬스케어 서비스</p>
					</div>
					<div class="sub">
						<p>당신의 관심과 사랑이</p>
						<p>반려동물에게 더 건강한 삶을 선물합니다.</p>
					</div>
				</div>
			</div>
			<script>
				var img_arr = new Array();
				var i=0;
	
				 img_arr[0]="url('/image/littlegolden.jpg')";
				 img_arr[2]="url('/image/back22.jpg')";
				 img_arr[3]="url('/image/back3.jpg')";
				 img_arr[3]="url('/image/golden.jpg')";
				 img_arr[4]="url('/image/back4.jpg')";
				 img_arr[1]="url('/image/back5.jpg')";
	
				 $(function(){
				  imgStart("R");
				 });
				 function imgStart(tp){
				  clearInterval($("#banner").attr("timer"));
				  if(tp == "R"){
				  $("#banner").attr("timer", setInterval("imgChange()", 6000));
				  }
				 }
				 
				 function imgChange(){
					  $("#banner").css("background", img_arr[i]);
					  i++;
					  if (i==4) i=0;
					  return i;
				 }
			</script>
		<!-- --------------------------------------------------------------------------------------- -->
		<div class="tools">
		<div id="diagnose"></div>
		
		<div class="diag_content">
			<p>" 간편하게 찍은 사진 한 장으로</p>
			<p>반려동물의 건강을 체크해보세요 "</p>
			<p id="diag_sub">믿을 수 있는 정확성으로 반려동물의 건강을 지키는 우리의 프로그램을 경험해보세요</p>
			<a href="/diagnosis/CheckTool"><div class="diag_button">서비스 이용해보기&ensp;<i class="fa-solid fa-arrow-right"></i></div></a>
		</div>
		
		</div>
		<!-- --------------------------------------------------------------------------------------- -->
		<div class="emergency">
		
		<div class="emer_content">
			<p>" 반려동물 응급상황,</p>
			<p>이제 당황하지 마세요 "</p>
			<p id="emer_sub">응급매뉴얼을 통해 신속하고 정확한 응급처치를 배우세요</p>
			<p id="emer_sub">소중한 반려동물의 생명을 지키는 중요한 가이드입니다</p>
			<a href="/emergency/emergency"><div class="emer_button">바로 확인하기&ensp;<i class="fa-solid fa-arrow-right"></i></div></a>
		</div>
		
		<div id="emer"></div>
		</div>
		<!-- ---------------------------------------------------------------------------- -->
		<div class="adopt">
			<div id="adoption">
				<div class="adopt_content">
					<p>" 따뜻한 집을 기다리는 친구들,</p>
					<p>함께 해주세요 "</p>
					<p id="adopt_sub">작은 발걸음이 그들에겐 큰 행복이 됩니다</p>
					<a href="/adoption/animalList"><div class="adopt_button">만나러 가기&ensp;<i class="fa-solid fa-arrow-right"></i></div></a>
				</div>
			</div>
		</div>
		<!-- ---------------------------------------------------------------------------- -->
    	</section>
		<%@ include file="footer/footer.jsp" %>
	
	</body>
</html>