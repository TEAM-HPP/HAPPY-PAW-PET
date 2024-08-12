<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<div class="diagnosis-able">
    <h3><i class="fa-solid fa-user-doctor"></i>&ensp;진단가능 질병 </h3>
    <ul>
        <li id="diag-title"><a href="#">안구 질환</a></li>
        <li><a href="https://terms.naver.com/entry.naver?docId=6619635&cid=42883&categoryId=69789"><i class="fa-solid fa-check"></i> 결막염</a></li>
        <li><a href="https://terms.naver.com/entry.naver?docId=988797&cid=42478&categoryId=42525"><i class="fa-solid fa-check"></i> 궤양성각막질환</a></li>
        <li><a href="https://terms.naver.com/entry.naver?docId=6602777&cid=42883&categoryId=69789"><i class="fa-solid fa-check"></i> 백내장</a></li>
        <li><a href="https://terms.naver.com/entry.naver?docId=988550&cid=42478&categoryId=42525"><i class="fa-solid fa-check"></i> 비궤양성각막질환</a></li>
        <br>
        <li id="diag-title"><a href="#">피부 질환</a></li>
        <li><a href="#"><i class="fa-solid fa-check"></i> 추후 개발 예정</a></li>
    </ul>
</div>
<div class="diagnosis-history">
    <h3><i class="fa-regular fa-folder-open"></i>&ensp;진단 이력</h3>
    <ul>
        <c:forEach var="history" items="${diagnosisHistory}">
            <li class="diagnosis-item">
                <div class="diagnosis-header">
                    <span class="diagnosis-id">반려동물 이름: ${history.pname}</span>
                    <span class="diagnosis-date">${history.diagnosisdate}</span>
                </div>
                <div class="diagnosis-content">
                    <strong>- 질병 유형:</strong> ${history.condition} <br>
                    <strong>- 추가 정보:</strong> ${history.additionalNotes}
                </div>
            </li>
        </c:forEach>
    </ul>
</div>

