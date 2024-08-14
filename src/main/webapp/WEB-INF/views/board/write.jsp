<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HappyPawPet 관리자글쓰기</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="/css/top.css">
  <link rel="stylesheet" href="/css/board/write.css">
  <link rel="stylesheet" href="/css/footer.css">
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script>
	  $(document).ready(function() {  //content 내용 input에 넣기
		    $("select[name=topck_select]").on("change", function() {
		        let topchk = $(this).val();
		        $("#topchk").val(topchk);
		    });
		});
  </script>
</head>
<body>
	<%@ include file="../top/top.jsp" %>
	<section>
	    <h1>관리자 글쓰기</h1>
	    <hr>
	
	    <form action="/board/write" name="write" method="post" enctype="multipart/form-data">
	      <table>
	        <colgroup>
	          <col width="15%">
	          <col width="85%">
	        </colgroup>
	        <tr>
	          <th>선택</th>
	          <td>
	          	<input type="hidden" name="topchk" id="topchk" value="0" required/>
	            <select name="topck_select">
					<option value="0" >선택안함</option>
					<option value="1">상위노출</option>
					<option value="2">필독</option>
				</select>
	          </td>
	        </tr>
	        <tr>
	          <th>작성자</th>
	          <td>
	            <input type="text" name="id" value="admin01" readonly="readonly">
	          </td>
	        </tr>
	        <tr>
	          <th>제목</th>
	          <td>
	            <input type="text" name="btitle">
	          </td>
	        </tr>
	        <tr>
	          <th>내용</th>
	          <td>
	            <textarea name="bcontent" cols="50" rows="10"></textarea>
	          </td>
	        </tr>
	        <tr>
	          <th>이미지 표시</th>
	          <td>
	            <input type="file" name="files" id="bfile">
	          </td>
	        </tr>
	      </table>
	      <hr>
	      <div class="button-wrapper">
	        <button type="submit" class="write">작성완료</button>
	        <button type="button" class="cancel" onclick="javascript:location.href='/board/list'">취소</button>
	      </div>
	    </form>
	
	  </section>
	  <!-- ----------------------------------------------------------------- -->
	  <%@ include file="../footer/footer.jsp" %>

	</body>
</html>