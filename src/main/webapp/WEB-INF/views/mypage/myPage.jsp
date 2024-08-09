<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/top.css" />
	<link rel="stylesheet" type="text/css" href="/css/mypage/mypage.css" />
	<link rel="stylesheet" type="text/css" href="/css/footer.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>MY PAGE</title>
<script>
	console.log("successM : ${successM}");
	if("${successM}" != ""){
		   alert("${successM}"); 
	   }
	
    function pdBtn(pno,pname){
    	if(confirm("정보를 삭제하시겠습니까?")){
    		alert(pname+"의 정보가 삭제되었습니다.");
    		location.href="/mypage/byePet?pno="+pno;
    	}
    }
</script>
<script>
    function open_pop(){
        var open_modal = document.querySelector(".modal");
        document.getElementById('modal_prewiew').src = "/upload/${mDto.profile }";
        open_modal.style.display = "flex";
    }
    function close_pop(){
    	$.ajax({
		   url:"/mypage/myPage",
		   type:"post",
		   dataType:"text",
		   enctype:"multipart/form-data",
		   data: new FormData($('#mainfileFrm')[0]),
		        processData: false,
		        contentType: false,
		        cache: false,
		   success:function(data){
		   	location.href="./myPage";
		   },
		   error:function(){
		   	alert("에러");
		   }
	   });//ajax
		
        var close_modal = document.querySelector(".modal");
        close_modal.style.display = "none";
        mainfileFrm.submit();
        document.getElementById('modal_prewiew').src = "/upload/${mDto.profile }";
    }
	// 선택한 파일을 미리보기로 표시합니다.
	function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
        	document.getElementById('modal_prewiew').src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]); // 파일을 Data URL로 읽기
    } else {
        // 선택된 파일이 없을 때의 처리 (파일 선택이 안 되었을 경우)
        document.getElementById('modal_prewiew').src = "/image/welcome.jpg"; // 기본 이미지
    }
}
</script>  
</head>
<body id="mypage">
<%@ include file="../top/top.jsp" %>
<!--  ---------------------------------------------------------------------------->
	<section>
        <div id="blank1"></div>
        <div id="main">
            <div id="sub_top_area">
                <h3>MY PAGE</h3>
            </div>
            <div id="personfile">
                <div id="image">
                    <a onclick="open_pop()"><img src="/upload/${mDto.profile }" alt="프로필 이미지" ></a>
                </div>
                <!-- modal 시작 -->
                <div class="modal">
		            <div class="modal_pop">
		                <h2>프로필 이미지 변경</h2>
		                <p>원하는 이미지를 선택해주세요.</p>
			    		<div id="modal_image">
		                   <img id="modal_prewiew"/>
		                </div>
		                <div id="modal_select">
		                    <form id="mainfileFrm" action="/mypage/sendMainImg" name="mainfileFrm" method="post" enctype="multipart/form-data" >
		                	<input type="file" id="mainFile" name="mainFile" accept=".jpg, .jpeg, .png, .gif" onchange="readURL(this);"/>
		                    </form>
		                </div>
		                <div id="modal_button">
			    		<button id="modal_btn" onclick="close_pop()">완료</button>
		                </div>
		            </div>
		        </div>
                <!-- modal 끝 -->
                <div id="info">
                        <div class="hello">${sessionName } 님 안녕하세요! &ensp;</div></a>
                    <div id="blank2"></div>
                        <a href="/mypage/checkPw"><div class="infoB" id="checkPW_button">회원정보 수정</div></a>
                        <a href="/mypage/changePw"><div class="infoB" id="changePw_button">비밀번호 변경</div></a>
                    <div id="blank2"></div>
                        <div class="infoC">${sessionName } 님의 반려동물 정보</div>
                        <div class="petlist">
							<h4>반려동물정보관리 (총 ${plist.size()} 마리)</h4>
							<c:forEach items="${plist }" var="pDto">
							<table id="pet">
								<colgroup>
							        <col style="width: 25%;"/>
							        <col style="width: 15%;"/>
							        <col style="width: 20%;"/>
							    </colgroup>
								<tbody>
									<tr>
										<td rowspan="8" style="background: #FAF7F0;border-top: none;border-left: none;
										border-bottom: none;"><img id="pfile" src="/upload/${pDto.pfile }"></td>
										<th>이름</th>
										<td>${pDto.pname}</td>
									</tr>
									<tr>
										<th>무게(kg)</th>
										<td>${pDto.pweight}</td>
									</tr>
									<tr>
										<th>생일</th>
										<td><fmt:formatDate value="${pDto.pbirth }" pattern="yyyy-MM-dd"/></td>
									</tr>
									<tr>
										<th>나이</th>
										<td>만 ${pDto.page }세</td>
									</tr>
									<tr>
										<th>성별</th>
										<td>${pDto.pgender }</td>
									</tr>
									<tr>
										<th>중성화여부</th>
										<td>${pDto.psurgery }</td>
									</tr>
									<tr id="button">
										<td colspan="2"><button type="button" id="uBtn" onclick="location.href='/mypage/petEdit?pno=${pDto.pno}'">수정하기</button></td>
									</tr>
									<tr id="button">
										<td colspan="2"><button type="button" id="pdBtn" onclick="pdBtn(${pDto.pno},'${pDto.pname}')">삭제하기</button></td>
									</tr>
								</tbody>
							</table>
							</c:forEach>
							<div id="blank4"></div>
							<button type="button" id="plus" onclick="location.href='petForm'">
								<i class="fa-solid fa-plus"></i>&ensp;반려동물 추가하기
							</button>
						</div>
                    </div>
                </div>
            <button type="button" class="dBtn" id="deleteInfo" onClick="location.href='byeMem'" style="top: 50px;">회원 탈퇴</button>
        <div id="blank3"></div>
        </div>	
    </section>
<!-- ---------------------------------------------------------------------------- -->
<%@ include file="../footer/footer.jsp" %>
</body>
</html>