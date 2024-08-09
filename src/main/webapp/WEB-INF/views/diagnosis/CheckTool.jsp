<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>HappyPawPet</title>
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/diagnosis/CheckTool.css" />
	<link rel="stylesheet" type="text/css" href="/css/diagnosis/diagnosisHistory.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#condition').change(function() {
				var selectedCondition = $(this).val();
				console.log("Selected condition: " + selectedCondition);
				if (selectedCondition === 'eye') {
					$('#eye-condition').show();
					$('#skin-condition').hide();
				} else if (selectedCondition === 'skin') {
					$('#eye-condition').hide();
					$('#skin-condition').show();
				} else {
					$('#eye-condition').hide();
					$('#skin-condition').hide();
				}
			});
		});

		function sBtn() {
			var formData = new FormData($("form[name=dFrm]")[0]);
			var selectedCondition = $("#condition").val();
			var userId = $("#id").val();
			var petName = $("#pname").val();

			//console.log("선택한 질환 유형: " + selectedCondition);

			$.ajax({
				url: "/diagnosis/comparePet",
				type: "post",
				data: {
					"id": userId,
					"pname": petName,
					"pbirth": $("#pbirth").val()
				},
				success: function(data) {
					console.log("comparePet response: " + data);
					if (data == "0") {
						if (confirm("새로운 반려동물 정보를 저장할까요?")) {
							$.ajax({
								url: "/diagnosis/joinPet",
								type: "post",
								data: formData,
								processData: false,
								contentType: false,
								success: function(data) {
									console.log("joinPet response: " + data);
									if (data == "OK") {
										alert("반려동물 저장을 완료했습니다.");
									}
								},
								error: function(xhr, status, error) {
									console.error("joinPet error:", error);
									alert("반려동물 정보 저장 중 에러가 발생했습니다: " + error);
								}
							});
						}
					}
					alert("진단화면으로 넘어갑니다.");

					// 진단 설문지 데이터를 포함하여 전송
					$.ajax({
						url: "/diagnosis/checkForm",
						type: "post",
						data: formData,
						processData: false,
						contentType: false,
						success: function(response) {
							console.log("checkForm response:", response);

							// 서버로부터 받은 응답을 파싱
							var result = JSON.parse(response);

							// 사용자가 선택한 condition 값에 따라 페이지 이동
							var condition = $("#condition").val();
							var resultPage;
							if (condition === "eye") {
								resultPage = "resultEye";
							} else if (condition === "skin") {
								resultPage = "resultSkin";
							} else {
								console.error("Unknown condition type:", condition);
								alert("알 수 없는 질병 유형입니다.");
								return;
							}

							// 페이지 이동 시 서버 응답 데이터를 쿼리 파라미터로 전달
							window.location.href = resultPage + "?disease=" + encodeURIComponent(result.disease) +
									"&probability=" + result.probability.toFixed(2) + "&userId=" + encodeURIComponent(userId) +
									"&petName=" + encodeURIComponent(petName) + "&file=" + encodeURIComponent(result.file);
						},
						error: function(xhr, status, error) {
							console.error("checkForm error:", error);
							alert("진단 처리 중 에러가 발생했습니다: " + error);
						}
					});
				},
				error: function(xhr, status, error) {
					console.error("comparePet error:", error);
					alert("반려동물 정보 비교 중 에러가 발생했습니다: " + error);
				}
			});
		}
	</script>
</head>
<body>
<%@ include file="../top/top.jsp" %>
<section>
	<div id="blank"></div>
	<div class="container">
		<div class="sidebar">
			<%@ include file="diagnosisHistory.jsp" %>
		</div>
		<div class="main-content">
			<h2>반려견 정보</h2>
			<form action="/diagnosis/checkForm" id="dFrm" name="dFrm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" id="id" value="${sessionId}">
				<div class="form-group">
					<label for="pname">이름</label>
					<input type="text" id="pname" name="pname" placeholder="반려견의 이름을 입력하세요" required>
				</div>
				<div class="form-group">
					<label for="pbirth">생년월일</label>
					<input type="date" id="pbirth" name="pbirth" max="2024-12-31" min="1980-01-01" required>
				</div>
				<div class="form-group">
					<label for="psex">성별</label>
					<select id="psex" name="psex" required>
						<option value="">선택</option>
						<option value="male">수컷</option>
						<option value="female">암컷</option>
					</select>
				</div>
				<div class="form-group">
					<label for="psurgery">중성화여부</label>
					<select id="psurgery" name="psurgery" required>
						<option value="">선택</option>
						<option value="yes">예</option>
						<option value="no">아니오</option>
					</select>
				</div>
				<div class="form-group">
					<label for="pweight">체중</label>
					<input type="text" id="pweight" name="pweight" placeholder="반려견의 체중을 입력하세요" required>
				</div>
				<div class="form-group">
					<label for="pbreed">견종</label>
					<input type="text" id="pbreed" name="pbreed" placeholder="반려견의 견종을 입력하세요" required>
				</div>
				<div class="form-group">
					<label for="condition">질병 유형</label>
					<select id="condition" name="condition" required>
						<option value="">선택하세요</option>
						<option value="eye">안구</option>
						<option value="skin">피부</option>
					</select>
				</div>

				<div id="questionnaire-section">
					<div id="eye-condition" style="display: none;">
						<jsp:include page="../conditions/eyeCondition.jsp" />
					</div>
					<div id="skin-condition" style="display: none;">
						<jsp:include page="../conditions/skinCondition.jsp" />
					</div>
				</div>

				<div class="form-group">
					<label for="file-upload">파일명:</label>
					<input type="file" id="file-upload" name="file" class="upload-button">
				</div>

				<div class="form-group">
					<button type="button" class="submit-button" onclick="sBtn()">제출</button>
				</div>
			</form>
		</div>
	</div>
</section>
<%@ include file="../footer/footer.jsp" %>
</body>
</html>