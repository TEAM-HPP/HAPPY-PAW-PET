<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/mypage/checkPw.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<title>HappyPawPet 비밀번호 확인</title>
	<script>
	function CBtn() {
        // 비밀번호가 입력되지 않은 경우 경고 표시
        if (!($("#check_pw").val())) {
            alert("비밀번호를 입력해 주세요.");
            return;
        }

	        // 폼을 서버로 제출
	        checkFrm.submit();
	    }
	
		function showError() {
			var errorMessage = $("#errorM").val();
	       if (errorMessage) {
	           alert(errorMessage);
	           $("#check_pw").focus();
	       }
  		 }
	</script>
	</head>
	<body id="checkPw" onload="showError()">
		<%@ include file="../top/top.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
		<section>
			<div class="subbanner"></div>
			<div class="main">
				<h2>비밀번호 확인</h2>
				<p>고객님의 안전한 정보 수정을 위한 비밀번호 확인입니다.</p>
				<p>HappyPawPet은 고객님의 정보를 안전하게 지키기 위해 최선을 다하겠습니다.</p>
				<form action="/mypage/checkPw" name="checkFrm" method="post">
				<input type="hidden" id="errorM" value="${errorM}" />
					<fieldset id="fieldset_class">
						<dl id="check">
							<dt>
								<div></div>
								<label for="check">비밀번호</label>
							</dt>
							<dd>
								<input type="password" id="check_pw" name="check_pw" minlength="8"
									placeholder="비밀번호를 입력하세요." autoComplete="off" required />
							</dd>
						</dl>
					</fieldset>
					<div></div>
					<button type="button" onclick="CBtn()" >회원 정보 수정</button>
				</form>
				
			</div>
		</section>
		<!-- ------------------------------------------------------------------------------------------------ -->
		<%@ include file="../footer/footer.jsp" %>
	</body>
</html>