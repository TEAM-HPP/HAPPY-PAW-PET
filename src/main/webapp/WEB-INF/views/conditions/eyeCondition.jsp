<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%--안구질환진단데이터 입력--%>
<div id="eye-condition">
	<h2>[안구질환과 관련된 사항을 체크해주세요]</h2>
	<div class="form-group">
		<label>1. 자주 부딪힌다.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye1_yes" name="eye1" value="1">
				<label for="eye1_yes">예</label>
				<input type="radio" id="eye1_no" name="eye1" value="0">
				<label for="eye1_no">아니오</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>2. 소리에 깜짝 놀란다.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye2_yes" name="eye2" value="1">
				<label for="eye2_yes">예</label>
				<input type="radio" id="eye2_no" name="eye2" value="0">
				<label for="eye2_no">아니오</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>3. 갑자기 사나워지는 등 성격변화가 보인다.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye3_yes" name="eye3" value="1">
				<label for="eye3_yes">예</label>
				<input type="radio" id="eye3_no" name="eye3" value="0">
				<label for="eye3_no">아니오</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>4. 충혈이 있다.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye4_yes" name="eye4" value="1">
				<label for="eye4_yes">예</label>
				<input type="radio" id="eye4_no" name="eye4" value="0">
				<label for="eye4_no">아니오</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>5. 눈에 경련이 있다.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye5_yes" name="eye5" value="1">
				<label for="eye5_yes">예</label>
				<input type="radio" id="eye5_no" name="eye5" value="0">
				<label for="eye5_no">아니오</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>6. 눈동자의 색깔을 선택해주세요.</label>
		<div class="radio-group">
			<div class="option-group">
				<input type="radio" id="eye6_green" name="eyecolor" value="green">
				<label for="eye6_green">녹색</label>
				<input type="radio" id="eye6_red" name="eyecolor" value="red">
				<label for="eye6_red">빨간색</label>
				<input type="radio" id="eye6_white" name="eyecolor" value="white">
				<label for="eye6_white">흰색</label>
				<input type="radio" id="eye6_black" name="eyecolor" value="black">
				<label for="eye6_black">검은색</label>
			</div>
		</div>
	</div>
</div>
