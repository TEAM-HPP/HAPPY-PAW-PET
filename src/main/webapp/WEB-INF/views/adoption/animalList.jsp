<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유기 강아지 목록</title>
    <link rel="stylesheet" type="text/css" href="/css/top.css"/>
    <link rel="stylesheet" type="text/css" href="/css/adoption/animalList.css"/>
    <link rel="stylesheet" type="text/css" href="/css/footer.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        function fetchSigungu(uprCd) {
            if (uprCd === "") {
                document.getElementById("sigungu").innerHTML = "<option value=''>시군구 선택</option>";
                return;
            }
            $.ajax({
                url: "/adoption/sigungu",
                data: { uprCd: uprCd },
                success: function(response) {
                    var sigunguSelect = document.getElementById("sigungu");
                    sigunguSelect.innerHTML = "<option value=''>시군구 선택</option>";
                    response.forEach(function(sigungu) {
                        var option = document.createElement("option");
                        option.value = sigungu.orgCd;
                        option.text = sigungu.orgdownNm;
                        sigunguSelect.appendChild(option);
                    });
                }
            });
        }
    </script>
</head>
<body>
<%@ include file="../top/top.jsp" %>
<main>
    <h1>새로운 가족이 되어주세요!</h1>
    <div class="filters">
        <form action="/adoption/animalList" method="get">
            <select name="uprCd" onchange="fetchSigungu(this.value)">
                <option value="">전국</option>
                <c:forEach items="${sidoList}" var="sido">
                    <option value="${sido.orgCd}" ${sido.orgCd == uprCd ? 'selected' : ''}>${sido.orgdownNm}</option>
                </c:forEach>
            </select>
            <select name="orgCd" id="sigungu">
                <option value="">시군구 선택</option>
                <c:if test="${not empty uprCd}">
                    <c:forEach items="${sigunguList}" var="sigungu">
                        <option value="${sigungu.orgCd}" ${sigungu.orgCd == orgCd ? 'selected' : ''}>${sigungu.orgdownNm}</option>
                    </c:forEach>
                </c:if>
            </select>
            <button type="submit">조회</button>
        </form>
    </div>
    <div class="total-count">총 ${totalCount}건</div>
    <div class="card-container">
        <c:forEach items="${animalList}" var="animal" varStatus="status">
            <div class="card ${status.index % 5 == 0 ? 'start-row' : ''}">
                <a href="/adoption/Adog_ex?desertionNo=${animal.desertionNo}">
                    <div class="card-content">
                        <div class="card-image-container">
                            <c:choose>
                                <c:when test="${not empty animal.popfile}">
                                    <img src="${animal.popfile}" alt="${fn:replace(animal.kindCd, '[개]', '')}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/image/default.jpg" alt="No Image">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-info">
                            <h2>
                                <c:choose>
                                    <c:when test="${fn:contains(animal.kindCd, '믹스견')}">
                                        별동이★
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:replace(animal.kindCd, '[개]', '')}
                                    </c:otherwise>
                                </c:choose>
                            </h2>
                            <p class="important-info">${animal.colorCd} / ${animal.age} / ${animal.weight}</p>
                            <p>성별: ${animal.sexCd} / 중성화: ${animal.neuterYn}</p>
                            <p class="contact-info">${animal.careNm} / ${animal.careTel}</p>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a class="location" href="/adoption/animalList?uprCd=${uprCd}&orgCd=${orgCd}&page=1">&lt;&lt;</a>
            <a class="location" href="/adoption/animalList?uprCd=${uprCd}&orgCd=${orgCd}&page=${currentPage - 1}">&lt;</a>
        </c:if>
        <c:forEach items="${paginationLinks}" var="link">
            <c:choose>
                <c:when test="${link == '...'}">
                    <span>${link}</span>
                </c:when>
                <c:otherwise>
                    <a id="num" href="/adoption/animalList?uprCd=${uprCd}&orgCd=${orgCd}&page=${link}" class="${link == currentPage ? 'active' : ''}">${link}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a class="location" href="/adoption/animalList?uprCd=${uprCd}&orgCd=${orgCd}&page=${currentPage + 1}">&gt;</a>
            <a class="location" href="/adoption/animalList?uprCd=${uprCd}&orgCd=${orgCd}&page=${totalPages}">&gt;&gt;</a>
        </c:if>
    </div>
</main>
<%@ include file="../footer/footer.jsp" %>
</body>
</html>
