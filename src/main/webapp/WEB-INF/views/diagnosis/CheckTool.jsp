<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				if (selectedCondition === 'eye') {
					$('#eye-condition').show();
					$('#skin-condition').hide();
					$('html, body').animate({
						scrollTop: $("#eye-condition").offset().top
					}, 1000);
				} else if (selectedCondition === 'skin') {
					$('#eye-condition').hide();
					$('#skin-condition').show();
					$('html, body').animate({
						scrollTop: $("#skin-condition").offset().top
					}, 1000);
				} else {
					$('#eye-condition').hide();
					$('#skin-condition').hide();
				}
			});
		});

	</script>
	<script>
		//아이디중복 확인
		function sBtn(){
			var id = $("#id").val();
			var pname = $("#pname").val();
			var pbirth = $("#pbirth").val();

			var formData = $("form[name=dFrm]").serialize()

			$.ajax({
				url:"/diagnosis/comparePet",
				type:"post",
				data:{"id":id, "pname":pname, "pbirth":pbirth},
				success:function(data){
					console.log("data : "+data);
					if(data == "0"){//일치하는 반려동물 정보 없음
						if(confirm("새로운 반려동물 정보를 저장할까요?")){
							$.ajax({
								url:"/diagnosis/joinPet",
								type:"post",
								data:formData,
								success:function(data){
									console.log("data : "+data);
									if(data == "OK"){//새롭게 저장 완료
										alert("반려동물 저장을 완료했습니다.");
									}
								},
								error:function(){
									alert("에러입니다.");
								}
							});//반려동물 정보저장 ajax
						}
					}
					alert("진단화면으로 넘어갑니다.");

					console.log($("#dFrm").attr("action"));
					dFrm.submit();
				},
				error:function(){
					alert("에러입니다.");
				}

			});//ajax
		}
	</script>
</head>
<body>
<%@ include file="../top/top.jsp" %>
<!-- ---------------------------------------------------------------- -->
<section>
	<div id="blank"></div>
	<div class="container">
		<div class="sidebar">
			<%@ include file="diagnosisHistory.jsp" %>
		</div>
		<div class="main-content">
			<h2>반려견 정보</h2>
			<form action="/diagnosis/checkForm" id="dFrm" name="dFrm" method="post" enctype="multipart/form-data">
				<!-- <form id="/diagnosis/checkForm" onsubmit="handleSubmit(event)" method="post" enctype="multipart/form-data"> -->
				<input type="hidden" name="id" id="id" value="${sessionId }">
				<div class="form-group">
					<label for="pname">이름</label>
					<input type="text" id="pname" name="pname" placeholder="반려견의 이름을 입력하세요" required>
				</div>
				<div class="form-group">
					<label for="pbirth">생년월일</label>
					<input type="date" id="pbirth" name="pbirth" max="2024-12-31" min="1980-01-01" required/>
				</div>
				<div class="form-group">
					<label for="psex">성별</label>
					<select id="sex" name="psex" required>
						<option value="">선택</option>
						<option value="male">수컷</option>
						<option value="female">암컷</option>
					</select>
				</div>
				<div class="form-group">
					<label for="psurgery">중성화여부</label>
					<select id="surgery" name="psurgery" required>
						<option value="">선택</option>
						<option value="yes">예</option>
						<option value="no">아니오</option>
					</select>
				</div>
				<div class="form-group">
					<label for="pweight">체중</label>
					<input type="text" id="weight" name="pweight" placeholder="반려견의 체중을 입력하세요" required>
				</div>
				<div class="form-group">
					<label for="pbreed">견종</label>
					<input type="text" id="breed" name="pbreed" placeholder="반려견의 견종을 입력하세요" required>
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
						<%@ include file="../conditions/eyeCondition.jsp" %>
					</div>
					<div id="skin-condition" style="display: none;">
						<%@ include file="../conditions/skinCondition.jsp" %>
					</div>
				</div>

				<div class="form-group">
					<label for="file-upload">파일명:</label>
					<input type="file" id="file-upload" name="files" class="upload-button">
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
