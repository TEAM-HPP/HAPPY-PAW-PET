<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/mypage/byeMem.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		function pBtn(){  // 비밀번호확인
			let pw = $("#pw").val();
			
			if (pw === "${sessionPw}"){
				$("#pwConfirm").text('비밀번호가 일치합니다.').css('color','blue');
			}else{
				$("#pwConfirm").text('비밀번호가 일치하지 않습니다.').css('color','red');
			}
			
			console.log("pw : "+pw);
				
		}
	
		function nBtn(){   // 이름확인
			let name = $("#name").val();
			
			if (name === "${sessionName}"){
				$("#nameConfirm").text('이름이 일치합니다.').css('color','blue');
			}else{
				$("#nameConfirm").text('이름이 일치하지 않습니다.').css('color','red');
			}
				
			console.log("name : "+name);
		}
	
		$(document).ready(function() {  //content 내용 input에 넣기
		    $("select[name=content_select]").on("change", function() {
		        let content = $(this).val();
		        $("#content").val(content);
		        console.log("content : " + $("#content").val());
		    });
		});

		function bBtn() {  // 회원탈퇴 버튼!!
			let pw = $("#pw").val();
			let name = $("#name").val();
			let genderC = $("input[name=gender]:checked").val();
			let content = $("#content").val();
			
			$("#genderC").val(genderC);
			
			if (name === "${sessionName}" && pw === "${sessionPw}"){
			    alert("회원탈퇴가 완료되었습니다.");
			    byeFrm.submit();
				
			}else{
				alert("회원 정보를 정확히 입력하여 주십시오.")
				
				return false;
			}
			
		}
	</script>
	<title>HappyPawPet 회원탈퇴</title>
	</head>
	<body id="findForm">
		<%@ include file="../top/top.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
		<section>
			<div class="subbanner"></div>
			<div class="main">
				<h2>회원탈퇴</h2>
				<form action="/mypage/byeMem" name="byeFrm" method="post">
				<input type="hidden" name="content" id="content">
				<input type="hidden" name="genderC" id="genderC">
				<input type="hidden" name="id" id="id" value="${sessionId}">
					<h4>
					본인확인 및 탈퇴사유
					<span>(* 항목은 필수 항목입니다.)</span>
					</h4>
					<fieldset class="fieldset_class">
						<dl id="pwF">
							<dt>
								<div></div>
								<label for="pw">비밀번호확인</label>
							</dt>
							<dd>
								<input type="password" id="pw" name="pw" oninput="pBtn()" required />
								<span id="pwConfirm">비밀번호를 확인하세요</span>
							</dd>
						</dl>
						<dl id="nameF">
							<dt>
								<div></div>
								<label for="name">이름</label>
							</dt>
							<dd>
								<input type="text" id="name" name="name" oninput="nBtn()" required/>
								<span id="nameConfirm">이름을 확인하세요.</span>
							</dd>
						</dl>
						<dl id="genderF">
						<dt>
							<div></div>
							<label for="gender">성별</label>
						</dt>
						<dd>
							<div>
								<input type="radio" name="gender" id="male" value="male" onchange="dBtn()" /> 
								<label for="male">남성</label> 
								<input type="radio" name="gender" id="female" value="female" onchange="dBtn()" /> 
								<label for="female">여성</label>
							</div>
						</dd>
					</dl>
						<dl id="contentF">
							<dt>
								<div></div>
								<label for="id">탈퇴하시는 이유</label>
							</dt>
							<dd>
								<select name="content_select">
								<option value="선택안함">선택안함</option>
								<option value="원하는 기능이 없음">원하는 기능이 없음</option>
								<option value="새로운 계정을 만들기 위함">새로운 계정을 만들기 위함</option>
								<option value="서비스 이용 빈도가 낮음">서비스 이용 빈도가 낮음</option>
								<option value="사용이 복잡함">사용이 복잡함</option>
								<option value="기술적 문제(버그, 오류 등)">기술적 문제(버그, 오류 등)</option>
								<option value="기타">기타</option>
							</select>
							</dd>
						</dl>
						
					</fieldset>
					<button type="button" onclick="bBtn()">회원탈퇴하기</button>
				</form>
				
			</div>
		</section>
		<!-- ------------------------------------------------------------------------------------------------ -->
		<%@ include file="../footer/footer.jsp" %>
	</body>
</html>