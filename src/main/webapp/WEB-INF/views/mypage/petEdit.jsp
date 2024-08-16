<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/mypage/petEdit.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>HappyPawPet 반려동물 정보 수정</title>
	<script>
		//몸무게 숫자만 가능!
		$(function(){
			$("#pweight").keyup(function(){
				if(!this.value.replace(/[^-\.0-9]/g, '')){
					$("#alert").css("display","inline-block");
				}else{
					$("#alert").css("display","none");
				}
				this.value=this.value.replace(/[^-\.0-9]/g, '');
			});
		});
	</script>
	<script>
		// controller로 회원가입정보 보내주기
		$(function(){
			$(".pBtn").click(function(){
				alert("저장되었습니다.")
				petFrm.submit();
			})
		});
	</script>
</head>
<body id="petForm">
<%@ include file="../top/top.jsp" %>
<!-- ------------------------------------------------------------------------- -->
<section>
	<div class="subbanner"></div>
	<div class="main">
		<h2>반려동물 정보 수정</h2>
		<form action="/mypage/doUpdatePet" name="petFrm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="sessionId" name="sessionId">
			<input type="hidden" id="pfile" name="pfile" value="${pDto.pfile }">
			<fieldset class="fieldset_class">
				<dl id="pname">
					<dt>
						<div></div>
						<label for="pname">이름</label>
					</dt>
					<dd>
						<input type="text" id="pname" name="pname" value="${pDto.pname }" required/>
					</dd>
				</dl>
				<dl id="p_weight">
					<dt>
						<div></div>
						<label for="pweight">무게</label>
					</dt>
					<dd>
						<input type="text" id="pweight" name="pweight" value="${pDto.pweight }" required />
						<span>&nbsp;kg</span>
						<span id="alert">* 숫자만 입력이 가능합니다.</span>
					</dd>
				</dl>
				<dl id="pbirth">
					<dt>
						<div></div>
						<label for="pbirth">생년월일</label>
					</dt>
					<dd>
						<input type="date" id="pbirth" name="pbirth"
							   max="2024-12-31" min="1930-01-01" onchange="pBtn()" value="${pDto.pbirth }"/>
						<div id="type">
							<input type="radio" name="calendar" id="lunar" value="lunar" checked="checked" />
							<label for="lunar">양력</label>
							<input type="radio" name="calendar" id="solar" value="solar" />
							<label for="solar">음력</label>
						</div>
					</dd>
				</dl>
				<dl id="pgender">
					<dt>
						<div></div>
						<label for="pgender">성별</label>
					</dt>
					<dd>
						<div>
							<input type="radio" name="pgender" id="male" value="male" checked="checked"
								   <c:if test="${pDto.pgender == 'male' }">checked</c:if>>
							<label for="male">남아</label>
							<input type="radio" name="pgender" id="female" value="female"
								   <c:if test="${pDto.pgender == 'female' }">checked</c:if>/>
							<label for="female">여아</label>
						</div>
					</dd>
				</dl>
				<dl id="psurgery">
					<dt>
						<div></div>
						<label for="psurgery">중성화 여부</label>
					</dt>
					<dd>
						<div>
							<input type="radio" name="psurgery" id="yes" value="yes" checked="checked"
								   <c:if test="${pDto.psurgery == 'yes' }">checked</c:if>/>
							<label for="yes">예</label>
							<input type="radio" name="psurgery" id="no" value="no"
								   <c:if test="${pDto.psurgery == 'no' }">checked</c:if>/>
							<label for="no">아니오</label>
						</div>
					</dd>
				</dl>
				<script>
					function readURL(input) {
						if (input.files && input.files[0]) {
							var reader = new FileReader();
							reader.onload = function(e) {
								document.getElementById('preview').src = e.target.result;
							};
							reader.readAsDataURL(input.files[0]);
						} else {
							document.getElementById('preview').src = "";
						}
					}
				</script>
				<dl id="pfile">
					<dt>
						<div></div>
						<label for="petfile">사진 첨부</label>
					</dt>
					<dd>
						<input type="file" id="petfile" name="petfile" accept=".jpg, .jpeg, .png, .gif" onchange="readURL(this);"/>
					</dd>
				</dl>
				<dl >
					<dt>
					</dt>
					<dd>
						<img id="preview" src="/image/noimage.jpg"/>
					</dd>
				</dl>
			</fieldset>
			<button type="button" class="pBtn">저장하기</button>
		</form>
	</div>
</section>
<!-- ------------------------------------------------------------------------------------------------ -->
<%@ include file="../footer/footer.jsp" %>
</body>
</html>