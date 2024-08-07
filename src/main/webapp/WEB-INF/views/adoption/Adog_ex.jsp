<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${animal.kindCd} - 상세 페이지</title>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="/css/top.css"/>
	<link rel="stylesheet" type="text/css" href="/css/adoption/Adog_ex.css"/>
	<link rel="stylesheet" type="text/css" href="/css/footer.css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d6a3e4e63ce6514f39f88e53f8535e7e&libraries=services"></script>
</head>
<body>
<%@ include file="../top/top.jsp" %>

<section>
	<div id='container'>
		<c:if test="${not empty errorMessage}">
			<div class="error-message">
					${errorMessage}
			</div>
		</c:if>
		<c:if test="${empty errorMessage and not empty animal}">
			<div id="pet_content">
				<div id="pet_detail">
					<div class='img_slide'>
						<div class='img'>
							<c:choose>
								<c:when test="${not empty animal.popfile}">
									<img src='${animal.popfile}' alt='${animal.kindCd}'>
								</c:when>
								<c:otherwise>
									<img src='/image/default.jpg' alt='No Image'>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class='info'>
						<p class='title'>
							<c:choose>
								<c:when test="${fn:contains(animal.kindCd, '믹스견')}">
									<span>[${animal.processState}]</span>별동이★
								</c:when>
								<c:otherwise>
									<span>[${animal.processState}]</span>${fn:replace(animal.kindCd, '[개]', '')}
								</c:otherwise>
							</c:choose>
						</p>
						<div class='detail_info'>
							<ul>
								<li><div class='dInfo'>공고번호</div><span>${animal.desertionNo}</span></li>
								<li><div class='dInfo'>나이</div><span>${animal.age}</span></li>
								<li><div class='dInfo'>품종</div><span>${fn:replace(animal.kindCd, '[개]', '')}</span></li>
								<li><div class='dInfo'>몸무게</div><span>${animal.weight}</span></li>
								<li><div class='dInfo'>성별</div><span>${animal.sexCd}</span></li>
								<li><div class='dInfo'>색깔</div><span>${animal.colorCd}</span></li>
								<li><div class='dInfo'>특징</div><span>${animal.specialMark}</span></li>
								<li><div class='dInfo'>중성화</div><span>${animal.neuterYn}</span></li>
								<li id='info_map'>
									<div class='dInfo'>보호위치</div>
									<div><span>${animal.careNm}</span></div>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='gil_title'><p>오시는 길</p></div>
				<div id='center_map' style="width:100%;height:400px;"></div>
				<div class='center_info'>
					<div class='center_address'>
						<p class='Caddress'>
							<img src="/image/map_icon.png" alt="Location Icon">
								${animal.careAddr}
						</p>
					</div>
					<div class='center_tel'>
						<span>TEL</span>
						<img src="/image/tel_ic.png" alt="Telephone Icon" class="tel_ic">
						<span>${animal.careTel}</span>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</section>

<%@ include file="../footer/footer.jsp" %>

<script>
	$(document).ready(function() {
		var shelterName = "${animal.careNm}";
		var shelterAddress = "${animal.careAddr}";

		console.log("Shelter Name:", shelterName);
		console.log("Shelter Address:", shelterAddress);

		if (shelterAddress && shelterAddress.trim() !== "") {
			var mapContainer = document.getElementById('center_map');
			var mapOption = {
				center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 3
			};

			var map = new kakao.maps.Map(mapContainer, mapOption);
			var geocoder = new kakao.maps.services.Geocoder();

			geocoder.addressSearch(shelterAddress, function(result, status) {
				console.log("Geocoder status:", status);
				if (status === kakao.maps.services.Status.OK) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					var marker = new kakao.maps.Marker({
						map: map,
						position: coords
					});

					var infowindow = new kakao.maps.InfoWindow({
						content: '<div style="width:150px;text-align:center;padding:6px 0;">' + shelterName + '</div>'
					});
					infowindow.open(map, marker);

					map.setCenter(coords);
				} else {
					console.log('Geocoding failed:', status);
					mapContainer.innerHTML = '지도를 표시할 수 없습니다.';
				}
			});
		} else {
			console.log('Invalid shelter address: ' + shelterAddress);
			document.getElementById('center_map').innerHTML = '주소 정보가 없어 지도를 표시할 수 없습니다.';
		}
	});
</script>
</body>
</html>
