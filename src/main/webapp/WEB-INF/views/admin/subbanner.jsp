<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
	    $("li[id^='s0']").click(function(){
	        $("div[id^='sub']").css("display","none"); // 모든 섹션 숨기기
	        var target = $(this).attr("id").replace("s0", "sub");
	        $("#" + target).css("display","block"); // 클릭된 버튼과 연결된 섹션만 표시
	    });
	});
</script>

<div class="banner">
	<div class="title"><a href="/admin/admin">ADMINISTRATOR</a></div>
	<div class="all">
		<div class="sub_left">
			<ul class="subbanner">
				<li id="s01" class="sub_title">
					<a href="#" class="sub_titlelink">회원관리</a>
				</li>
				<li id="s02" class="sub_title">
					<a href="#" class="sub_titlelink">진단내역</a>
				</li>
				<li id="s03" class="sub_title">
					<a href="#" class="sub_titlelink">반려동물관리</a>
				</li>
				<li id="s04" class="sub_title">
					<a href="#" class="sub_titlelink">게시판</a>
				</li>
			</ul>
		</div>
		<!-- ----------------------------------------------------------------- -->
		<div class="sub_right">
			<div class="sub" id="sub1">
				<ul class="subcontent">
					<li><a href="/admin/member" class="sub_link">등록회원리스트</a></li>
					<li><a href="/admin/member" class="sub_link">탈퇴회원리스트</a></li>
				</ul>
			</div>
			<div class="sub" id="sub2">
				<ul class="subcontent">
					<li><a href="#" class="sub_link">안구질환</a></li>
					<li><a href="#" class="sub_link">피부질환</a></li>
				</ul>
			</div>
			<div class="sub" id="sub3">
				<ul class="subcontent">
					<li><a href="/admin/pet" class="sub_link">등록현황</a></li>
				</ul>
			</div>
			<div class="sub" id="sub4">
				<ul class="subcontent">
					<li><a href="/admin/boardDetail" class="sub_link">공지사항리스트</a></li>
					<li><a href="/admin/qna" class="sub_link">Q&A리스트</a></li>
					<li><a href="/admin/adoption" class="sub_link">입양공고커뮤니티</a></li>
				</ul>
			</div>
			<!-- ---------------------------------------------------------------------------- -->
		</div>
	</div>
</div>
