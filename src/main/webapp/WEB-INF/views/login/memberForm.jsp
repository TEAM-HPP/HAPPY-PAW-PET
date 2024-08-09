<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/login/memberForm.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(function(){
			$("#q06").click(function(){
				if (${sessionId == null}){
					alert("로그인 이후 이용 가능한 페이지입니다.");
					location.href="/login/login";
				}else{
					location.href="/mypage/myPage";
				}
			});
			
			$("select[name=domain_select]").on("change", function(){
				let addr = $(this).closest("#email").find("input[name=mail_tail]");
				if ($(this).val() == ""){
					addr.val('');
					addr.prop("readonly", false);
				} else{
					addr.val($(this).val());
					$(addr.prop("readonly",true));
				}
				
			});//이메일 클릭
			
		});
	</script>
	<script>
		//아이디중복 확인
		function cBtn(){
			var id = $("#id").val();
			const id_pattern = /^[a-zA-Z0-9]{4,16}$/;
			$.ajax({
				url:"/login/compareId",
				type:"post",
				data:{"id":id},
				success:function(data){
					console.log("data : "+data);
					if(data=="0"){//중복 아이디 없음
						if(!id_pattern.test(id)) {
					        alert("아이디는 4~16자리 영문, 숫자만 가능합니다!");
					        $("#id").focus();
							$("#id").val('');
							$("#NewId").css("display","none");
							$("#AlreadId").css("display","none");
					        return false;
						}else{
							$("#NewId").css("display","inline-block");
							$("#AlreadId").css("display","none");
						}
						
					} else{
						$("#NewId").css("display","none");
						$("#AlreadId").css("display","inline-block");
						alert("아이디를 다시 입력해주세요.");
						$("#id").val('');
						
					}
				},
				error:function(){
					alert("에러입니다.");
				}
				
			});//ajax
		};
	</script>
	<script>
		// onclick형식, 비밀번호 생성
		var newPwVar = false;
		function newPw(){
			var pw = $("#pw1").val();
			var hasLetter = /[a-zA-Z]/.test(pw);
			var hasNumber = /[0-9]/.test(pw);
			var specialChar = /[!@#$%^&*+?]/.test(pw);
			
			var cnt = 0;
			if (hasLetter) cnt++; //문자가 포함되면 ++
			if (hasNumber) cnt++; //숫자가 포함되면 ++
			if (specialChar) cnt++; //특수문자가 포함되면 ++
				
			if (cnt == 2){
				if(pw.length >= 10){
					$("#NewPw").css("display","inline-block");
					$("#NoPw").css("display","none");
					newPwVar = true;
				}else{
					$("#NewPw").css("display","none");
					$("#NoPw").css("display","inline-block");
				}
			}else if(cnt == 3){
				if(pw.length >= 8){
					$("#NewPw").css("display","inline-block");
					$("#NoPw").css("display","none");
					newPwVar = true;
				}else{
					$("#NewPw").css("display","none");
					$("#NoPw").css("display","inline-block");
				}
			}else{
					$("#NewPw").css("display","none");
					$("#NoPw").css("display","inline-block");
			}
			
		}
		//비밀번호 확인
		var pwCheckVar = false;
		function pwCheck(){
			if($("#pw1").val() == $("#pw2").val()){
				$("#pwConfirm").text('비밀번호가 일치합니다.').css('color','blue');
				pwCheckVar = true;
			}else{
				$("#pwConfirm").text('비밀번호가 일치하지 않습니다.').css('color','red');
			}
		}
		
		/*function dBtn(){
			console.log("date : "+$("#birth_year").val());
			console.log("gender : "+$("input[name=gender]:checked").val());
		}*/
	</script>
	<script> //전화번호 숫자만 가능!
	   $(function(){
		  $("#f_tell").keyup(function(){
			  if(!this.value.replace(/[^0-9]/g,'')){
				$("#alert").text("* 숫자만 입력이 가능합니다.");
			  }else{
				  $("#alert").text("");
			  }
			  this.value=this.value.replace(/[^0-9]/g,'');
		  });
		  $("#m_tell").keyup(function(){
			  if(!this.value.replace(/[^0-9]/g,'')){
				$("#alert").text("* 숫자만 입력이 가능합니다.");
			  }else{
				  $("#alert").text("");
			  }
			  this.value=this.value.replace(/[^0-9]/g,'');
		  });
		  $("#l_tell").keyup(function(){
			  if(!this.value.replace(/[^0-9]/g,'')){
				$("#alert").text("* 숫자만 입력이 가능합니다.");
			  }else{
				  $("#alert").text("");
			  }
			  this.value=this.value.replace(/[^0-9]/g,'');
		  });
	   });
	</script>
	<script>
		// controller로 회원가입정보 보내주기
		$(function(){
			$(".mBtn").click(function(){
				let fullEmail = $("#mail_id").val()+'@'+$("#mail_tail").val();
				let fullTell = $("#f_tell").val()+'-'+$("#m_tell").val()+'-'+$("#l_tell").val();
				let genderC = $("input[name=gender]:checked").val();
				
				$("#fullEmail").val(fullEmail);
				$("#fullTell").val(fullTell);
				$("#genderC").val(genderC);
				
				if ($("input[name=termAll]:checked").length === 0){
		        	alert("필수 약관에 동의하셔야합니다.")
		        	return false;
		        }
				if (!newPwVar) {
			        alert("새 비밀번호의 조건이 만족되지 않았습니다. 다시 입력해주세요.");
			        $("#newPw1").focus();
			        return false; // 폼 제출 방지
			    }
				if(!pwCheckVar){
					alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다. 다시 입력해주세요.")
	    			$("#newPw2").focus();
	    			return false; 	
	    	    }
				memFrm.submit();
		     });
		});
	</script>
	<title>HappyPawPet 회원가입창</title>
	</head>
	<body id="memberForm">
		<%@ include file="../top/top.jsp" %>
		<!-- ------------------------------------------------------------------------- -->
	<section>
		<div class="subbanner"></div>
		<div class="main">
			<h2>회원가입</h2>
			<form action="/login/join" name="memFrm" method="post">
				<input type="hidden" id="fullEmail" name="fullEmail"> 
				<input type="hidden" id="fullTell" name="fullTell">
				<input type="hidden" id="genderC" name="genderC">
				<h4>
					필수 정보 입력 <span>(* 항목은 필수 항목입니다.)</span>
				</h4>
				<fieldset class="fieldset_class">
					<dl id="nameF">
						<dt>
							<div></div>
							<label for="name">이름</label>
						</dt>
						<dd>
							<input type="text" id="name" name="name" required />
						</dd>
					</dl>
					<dl id="idF">
						<dt>
							<div></div>
							<label for="id">아이디</label>
						</dt>
						<dd>
							<input type="text" id="id" name="id" minlength="4" maxlength="16"
								required /> <input type="button" value="중복확인" onclick="cBtn()" />
							<div id="NewId">
								<i class="fa-solid fa-check" style="color: #226853;"></i>&ensp;사용
								가능한 아이디입니다.
							</div>
							<div id="AlreadId">
								<i class="fa-solid fa-xmark" style="color: #e21212;"></i>&ensp;이미
								존재하는 아이디입니다.
							</div>
							<span>4~16자리의 영문, 숫자만 사용하실 수 있습니다.</span> <span>첫 글자는 영문으로
								입력해 주세요.</span>
						</dd>
					</dl>
					<dl id="pwF">
						<dt>
							<div></div>
							<label for="pw">비밀번호</label>
						</dt>
						<dd>
							<input type="password" id="pw1" name="pw1" minlength="8"
								oninput="newPw()" placeholder="비밀번호 입력" required />
							<div id="NewPw">
								<i class="fa-solid fa-check" style="color: #226853;"></i>&ensp;사용
								가능한 비밀번호입니다.
							</div>
							<div id="NoPw">
								<i class="fa-solid fa-check" style="color: #e21212;"></i>&ensp;사용
								불가능한 비밀번호입니다.
							</div>
							<span>영문, 숫자, 특수문자(!@#$%^&*+?) 중 2종류 조합 시 10자리 이상 입력</span> <span>영문,
								숫자, 특수문자(!@#$%^&*+?) 모두 조합 시 8자리 이상 입력</span>
						</dd>
					</dl>
					<dl id="pw2F">
						<dt>
							<div></div>
							<label for="pw2">비밀번호 확인</label>
						</dt>
						<dd>
							<input type="password" id="pw2" name="pw2" minlength="8"
								oninput="pwCheck()" placeholder="비밀번호 확인" required /> <span
								id="pwConfirm">비밀번호를 확인하세요.</span>
						</dd>
					</dl>
					<dl id="email">
						<dt>
							<div></div>
							<label for="mail_id">이메일</label>
						</dt>
						<dd>
							<input type="text" id="mail_id" name="mail_id" required /> <span>@</span>
							<input type="text" id="mail_tail" name="mail_tail" required value="" /> 
							<select name="domain_select">
								<option value="">직접입력</option>
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
								<option value="nate.com">nate.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="empal.com">empal.com</option>
								<option value="dreamwiz.com">dreamwiz.com</option>
							</select>
						</dd>
					</dl>
					<dl id="tell">
						<dt>
							<div></div>
							<label for="f_tell">휴대전화</label>
						</dt>
						<dd>
							<input type="text" id="f_tell" name="f_tell" maxlength="3"
								required /> <span> - </span> <input type="text" id="m_tell"
								name="m_tell" maxlength="4" required /> <span> - </span> <input
								type="text" id="l_tell" name="l_tell" maxlength="4" required /><span id="alert"></span>
						</dd>
					</dl>
					<dl id="birth">
						<dt>

							<label for="birth_year">생년월일</label>
						</dt>
						<dd>
							<input type="date" id="birth_year" name="birth_year"
								max="2024-12-31" min="1930-01-01" onchange="dBtn()" />
							<div id="type">
								<input type="radio" name="calendar" id="lunar" value="lunar" checked="checked" /> 
									<label for="lunar">양력</label> 
									<input type="radio" name="calendar" id="solar" value="solar" /> 
									<label for="solar">음력</label>
							</div>
						</dd>
					</dl>
					<dl id="gender_w">
						<dt>
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
				</fieldset>
				<!-- 약관동의 form ------------------------------------------------------------------------------------------------------>
				<script>
			        document.addEventListener('DOMContentLoaded', function() {
			            const mainCheckbox = document.querySelector('.term_checkbox_all');
			            const subCheckboxes = document.querySelectorAll('.term_checkbox');
			
			            mainCheckbox.addEventListener('change', function() {
			                const isChecked = mainCheckbox.checked;
			
			                subCheckboxes.forEach(function(checkbox) {
			                    checkbox.checked = isChecked;
			                    updateCheckboxIcon(checkbox);
			                });
			                updateCheckboxIcon(mainCheckbox);
			            });
			
			            subCheckboxes.forEach(function(checkbox) {
			                checkbox.addEventListener('change', function() {
			                    updateCheckboxIcon(this);
			                    updateMainCheckbox();
			                });
			            });
			
			            function updateMainCheckbox() {
			                const allChecked = Array.from(subCheckboxes).every(function(cb) {
			                    return cb.checked;
			                });
			                mainCheckbox.checked = allChecked;
			                updateCheckboxIcon(mainCheckbox);
			            }
			
			            function updateCheckboxIcon(checkbox) {
			                const beforeCheckIcon = checkbox.parentElement.querySelector('.icon-before-check');
			                const afterCheckIcon = checkbox.parentElement.querySelector('.icon-after-check');
			
			                if (checkbox.checked) {
			                    beforeCheckIcon.style.display = 'none';
			                    afterCheckIcon.style.display = 'inline-block';
			                } else {
			                    beforeCheckIcon.style.display = 'inline-block';
			                    afterCheckIcon.style.display = 'none';
			                }
			            }
			        });
			        
			        
			    </script>
				<div class="agreeForm">
					<div class="term__">
						<h1>이용약관 동의</h1>
						<div class="total__">
							<div class="checkTerm" id="border">
								<input type="checkbox" name="termAll" class="term_checkbox_all"
									style="height: 40px;"> <i
									class="fa-solid fa-exclamation icon-before-check"></i> <i
									class="fas fa-solid fa-check icon-after-check"></i> <label>모두
									동의합니다.</label>
							</div>
							<div class="alert">* 이용약관(필수), 개인정보처리방침(필수)</div>
						</div>
						<ul class="termList">
							<li>
								<div class="checkTerm">
									<input type="checkbox" name="term" class="term_checkbox"
										style="height: 40px;"> <i class="fa-solid fa-exclamation icon-before-check"></i> 
										<i class="fas fa-solid fa-check icon-after-check"></i> <label><b>(필수)&nbsp;</b>이용약관동의</label>
										<li><textarea readonly style="width: 1100px;">1. 수집하는 개인정보의 항목 및 수집 방법
(1)수집하는 개인정보 항목
- 성명, 아이디, 비밀번호
- 이메일주소, 전화번호
- 생년월일, 성별
- (견) 이름, 무게, 생년월일, 성별, 중성화유무
- IP Address

(2)수집 방법
(주)HappyPawPet은 이용자가 자발적으로, 구체적으로 기입할 때 개인정보를 수집하고 있습니다.

2. 개인정보 수집 및 이용목적
- 회원제 서비스 이용에 따른 본인 확인 절차에 이용
- 개인맞춤 서비스를 제공하기 위한 자료
- 불량회원의 부정 이용 방지와 비인가 사용 방지

3. 개인정보의 보유 및 이용기간
- 계약 또는 청약철회 등에 관한 기록 : 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
- 회원가입 탈퇴하거나 회원에서 제명된 경우 등에는 3개월 동안 재가입 방지를 위하여 식별정보를 보관합니다.</textarea></li>
							</li>
							<br>
							<li>
								<div class="checkTerm">
									<input type="checkbox" name="term" class="term_checkbox"
										style="height: 40px;"> <i
										class="fa-solid fa-exclamation icon-before-check"></i> <i
										class="fas fa-solid fa-check icon-after-check"></i> <label><b>(필수)&nbsp;</b>개인정보처리방침동의</label>
									<li><textarea readonly style="width: 1100px;">제1조(목적 등)
① HappyPawPet 인터넷 회원 약관(이하 "본 약관"이라 합니다)은 이용자가 HappyPawPet에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있어 이용자와 HappyPawPet에 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
② 이용자가 되고자 하는 자가 HappyPawPet가 정한 소정의 절차를 거쳐서 "회원가입" 단추를 누르면 본 약관에 동의하는 것으로 간주합니다. 본 약관에 정하는 이외의 이용자와 HappyPawPet에 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.

제2조(이용자 정의)
"이용자"란 HappyPawPet 홈페이지에 접속하여 본 약관에 따라 HappyPawPet 인터넷 회원으로 가입하여 HappyPawPet 인터넷 회원 서비스를 받는 자를 말합니다.

제3조(회원가입)
① 이용자가 되고자 하는 자는 HappyPawPet가 정한 가입 양식에 따라 회원정보를 기입하고 "회원가입" 단추를 누르는 방법으로 회원 가입을 신청합니다.
② HappyPawPet는 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하는 경우 회원등록을 거부할 수 있고 기입한 데이터를 삭제할 수 있습니다.
1. 가입신청자가 본 약관 제6조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제6조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 HappyPawPet에 회원재가입 승낙을 얻은 경우에는 예외로 합니다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 HappyPawPet에 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립시기는 HappyPawPet에 승낙이 가입신청자에게 도달한 시점으로 합니다.
④ 회원은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다.

제4조(서비스의 제공 및 변경)
① HappyPawPet 인터넷 회원 서비스는 이용자에게 아래와 같은 서비스를 제공합니다.
1. AI 안구 진단 서비스
2. AI 피부 진단 서비스
3. 진단에 따른 사료, 영양제, 샴푸 추천 서비스
4. 유기견 입양 정보 
5. 응급처치 정보
6. 기타 HappyPawPet가 회원들에게 제공할 일체의 서비스
② HappyPawPet는 그 변경될 서비스의 내용 및 제공일자를 제7조 제2항에서 정한 방법으로 이용자에게 통지하고, 제1항에 정한 서비스를 변경하여 제공할 수 있습니다.

제5조(서비스의 중단)
① HappyPawPet는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있고, 새로운 서비스로의 교체 기타 HappyPawPet가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.
② 제1항에 의한 서비스 중단의 경우에는 HappyPawPet는 제7조 제2항에서 정한 방법으로 이용자에게 통지합니다. 다만, HappyPawPet가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.

제6조(이용자 탈퇴 및 자격 상실 등)
① 이용자는 HappyPawPet에 언제든지 자신의 회원 등록을 말소해 줄 것(이용자 탈퇴)을 요청할 수 있으며 HappyPawPet는 위 요청을 받은 즉시 해당 이용자의 회원 등록 말소를 위한 절차를 밟습니다.
② 이용자가 다음 각 호의 사유에 해당하는 경우, HappyPawPet는 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.
1. 가입 신청 시에 허위 내용을 등록한 경우
2. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우
3. 서비스를 이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ HappyPawPet가 이용자의 회원자격을 상실시키기로 결정한 경우에는 회원등록을 말소합니다. 이 경우 이용자인 회원에게 회원등록 말소 전에 이를 통지하고, 소명할 기회를 부여합니다.

제7조(이용자에 대한 통지)
① HappyPawPet가 특정 이용자에 대한 통지를 하는 경우 회원가입 시 기입한 메일주소로 할 수 있습니다.
② HappyPawPet가 불특정다수 이용자에 대한 통지를 하는 경우 1주일이상 HappyPawPet 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.
제8조(이용자의 개인정보보호)
HappyPawPet는 관련법령이 정하는 바에 따라서 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니다. 이용자의 개인정보보호에 관해서는 관련법령 및 HappyPawPet가 정하는 "개인정보보호정책"에 정한 바에 의합니다.

제9조(이용자의 ID 및 비밀번호에 대한 의무)
① HappyPawPet가 관계법령, "개인정보보호정책"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리책임은 각 이용자에게 있습니다.
② 이용자는 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 이용자는 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 HappyPawPet에 통보하고 HappyPawPet에 안내가 있는 경우에는 그에 따라야 합니다.

제10조(이용자의 의무)
① 이용자는 다음 각 호의 행위를 하여서는 안됩니다. 1. 회원가입신청 또는 변경시 허위내용을 등록하는 행위
2. 서비스에 게시된 정보를 변경하는 행위
3. HappyPawPet 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위
4. 다른 회원의 ID를 도용하는 행위
5. HappyPawPet의 승인 없이 자료의 무단 복제, 배부 임의 변경하거나 가공 또는 판매하거나 기타 영리를 목적으로 사용하는 행위
6. 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보의 전송 또는 게시하는 행위
7. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기 타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위
8. 다른 이용자에 대한 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위
9. HappyPawPet가 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위
② 제1항에 해당하는 행위를 한 이용자가 있을 경우 HappyPawPet는 본 약관 제6조 제2, 3항에서 정한 바에 따라 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.
③ 이용자는 그 귀책사유로 인하여 HappyPawPet는 다른 이용자가 입은 손해를 배상할 책임이 있습니다.

제11조(저작권의 귀속 및 이용제한)
① HappyPawPet가 작성한 저작물에 대한 저작권 기타 지적재산권은 HappyPawPet에 귀속합니다.
② 이용자는 서비스를 이용함으로써 얻은 정보를 HappyPawPet의 사전승낙 없이 자료의 무단 복제, 배부 임의 변경하거나 가공 또는 판매하거나 기타 영리를 목적으로 사용하여서는 안됩니다.

제12조 (약관의 개정)
① HappyPawPet는 약관의 규제 등에 관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
② HappyPawPet가 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
③ HappyPawPet가 본 약관을 개정할 경우에는 그 개정약관은 개정된 내용이 관계 법령에 위배되지 않는 한 개정 이전에 회원으로 가입한 이용자에게도 적용됩니다.
④ 변경된 약관에 이의가 있는 이용자는 제6조 제1항에 따라 탈퇴할 수 있습니다.
										</textarea>
										</li>
								</div>
							</li>
						</ul>
					</div>
					<button type="button" class="mBtn">가입하기</button>
				</div>
			</form>
		</div>
	</section>
	<!-- ------------------------------------------------------------------------------------------------ -->
		<%@ include file="../footer/footer.jsp" %>
	</body>
</html>