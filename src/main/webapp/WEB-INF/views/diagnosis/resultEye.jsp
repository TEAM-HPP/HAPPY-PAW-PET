<%--안구질환진단 결과--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="stylesheet" type="text/css" href="/css/top.css">
	<link rel="stylesheet" type="text/css" href="/css/diagnosis/dom.css">
	<link rel="stylesheet" type="text/css" href="/css/footer.css">
	<title>HappyPawPet 진단내역</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<%@ include file="../top/top.jsp" %>
		<section>
		<div class="box1">
			<h2 id="heading" style="width: 400px; height: 100px; margin: 100px 10px 1px 350px;
			font-size: 43px;">oo님의 강아지 사진</h2>
			<div id="prod-img" style="float: left; margin-right: 40px; margin: 1px 10px 30px 350px;">
				<img src="/image/dogeye.jfif" alt="백내장" width="600" height="400">
			</div>
		</div>

		<div class="box2" style="width: 600px; height: 400px; display: inline-block; margin: 1px 10px 20px 350px;">
				<h2 class="heading2" style="font-weight: 1000;">질환 정보</h2>
				<p>oo님 강아지가 가지고 있는 질환으로 의심되는 <span style="color:red;">백내장</span>은 눈의 수정체가 흐려지거나 불투명해져 시력에 장애를 주는 질환입니다. 한쪽 또는 양쪽 눈에 연령에 관계없이 발병할 수 있는 백내장은 동물 중에서도 강아지에게 비교적 흔한 편으로,
					모든 강아지의 8%가 일생의 어느 시점에 백내장에 걸릴 수 있다고 추정됩니다.</p>
		</div>


		<div id="rightDiv">
			<div id="result" style="margin: -850px 50px 50px 1150px;">
				<h2 class="resultTitle" style="width: 1000px; height: 60px;font-size: 43px;">진단 결과</h2>
				<p style="width: 500px; height: 20px; font-size: 40px;">‘00 님의 반려견 혹은 00(강아지 이름)의 의심 질환은 ‘백내장’입니다.</p>
				<br><br><br><br><br><br>
				<p style="width: 1000px; height: 50px; font-size: 30px;">확률: 00%</p>
			</div>
		</div>

		<div id="information" style="margin: -250px 50px 50px 350px;">
			<div id="drug">
				<h3 class="subTitle">추천 강아지 영양제</h3>
				<ul>
					<img src="/image/eyedrug.jpg" alt="백내장" width="300" height="250"
						style="margin: 1px 100px 1px 10px" >
						<li><a href="/food">디페토 강아지 눈물자국 눈 영양제 굿 아이즈 루테인</a></li>
						<li>55,900원</li>
						<button type="button" class="navyBtn"
						onClick="location.href='https://brand.naver.com/depeto/products/5440483258?NaPm=ct%3Dlyz767u0%7Cci%3Df1ea328eb80190264023f3dba8f13a34bc0676b9%7Ctr%3Dsls%7Csn%3D3176618%7Chk%3D0a3a5deee3cb272bc8a9dd5905ded3f3ed679343'" >
						해당 홈페이지 바로가기</button>
				</ul>
			</div>
			<div id="food" style="margin: -380px 100px 250px 500px">
					<h3 class="subTitle">추천 강아지 사료</h3>
					<ul>
						<img src="/image/foodeye.jpg" alt="백내장" width="300" height="250"
						style="margin: 1px 100px 1px 10px">
						<li><a href="/food">[마이펫닥터] 시그니처 티어스 컨트롤 강아지 사료 유기농(70%)</a></li>
						<li>18,000원</li>
						<button type="button" class="navyBtn"
						onClick="location.href='https://brand.naver.com/drmypet/products/4920733242?NaPm=ct%3Dlyz49sko%7Cci%3D033f6ba53007e43d295a0bad96f1f17bd4f8dd13%7Ctr%3Dslsbrc%7Csn%3D430989%7Chk%3D647c0dfc5509534b32e6b985cee4642400a5393c'">
						해당 홈페이지 바로가기</button>

					</ul>
			</div>
			<div id="medicine" style="margin: -620px 300px 250px 1050px">
				<h3 class="subTitle">추천 강아지 안약</h3>
				<ul>
					<img src="/image/eyemedicine.jpg" alt="백내장" width="300" height="250"
					style="margin: 1px 100px 1px 10px">
					<li><a href="/food">미국정품 강아지 백내장 안약 루멘프로</a></li>
					<li>87,400원</li>
					<button type="button" class="navyBtn"
					onClick="location.href='https://usapet.net/product/detail.html?product_no=113&cate_no=24&display_group=1&cafe_mkt=naver_ks&mkt_in=Y&ghost_mall_id=naver&ref=naver_open&NaPm=ct%3Dlyz7f8og%7Cci%3D37c161caffd1fb085d977c182f6eab39aa21e50a%7Ctr%3Dsls%7Csn%3D1205275%7Chk%3D11418e3818f2f9d58aee1725e9c813678e3b4dea'">
					해당 홈페이지 바로가기</button>

				</ul>
			</div>
		</div>
		</section>
		<%@ include file="../footer/footer.jsp" %>
</body>
</html>