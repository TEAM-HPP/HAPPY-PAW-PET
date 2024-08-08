<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>emergency</title>

    <!-- CSS FILES -->
    <link rel="stylesheet" type="text/css" href="/css/top.css"/>
    <link rel="stylesheet" type="text/css" href="/css/footer.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&family=Sono:wght@200;300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/emergency/bootstrap.min.css">
    <link rel="stylesheet" href="/css/emergency/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/emergency/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/emergency/owl.theme.default.min.css">
    <link href="/css/emergency/templatemo-pod-talk.css" rel="stylesheet">
    <link href="/css/emergency/content.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/emergency/modal.css">
</head>
<body>
<%@ include file="../top/top.jsp" %>

<main>
    <!-- modal 1 start -->
    <c:forEach items="${modal_list}" var="mList">
        <div class="modal_screen" id="modal_${mList.emer_no}">
            <a class="modal_cancle">
                <div class="modal_screen2">
                    <div class="modal_title">
                        <h3>${mList.title}</h3>
                        <p>${mList.content}</p>
                    </div>
                    <div class="modal_content">
                        <ul class="modal_list">
                            <div class="modal_step"><h2>Step 01.</h2></div>
                            <div class="modal_text">${mList.step_cont1}</div>
                            <img src="${mList.step_img1}" class="modal_img">
                        </ul>
                        <ul class="modal_list">
                            <div class="modal_step"><h2>Step 02.</h2></div>
                            <div class="modal_text">${mList.step_cont2}</div>
                            <img src="${mList.step_img2}" class="modal_img">
                        </ul>
                        <ul class="modal_list">
                            <div class="modal_step"><h2>Step 03.</h2></div>
                            <div class="modal_text">${mList.step_cont3}</div>
                            <img src="${mList.step_img3}" class="modal_img">
                        </ul>
                        <ul class="modal_list">
                            <div class="modal_step"><h2>Step 04.</h2></div>
                            <div class="modal_text">${mList.step_cont4}</div>
                            <img src="${mList.step_img4}" class="modal_img">
                        </ul>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
    <!-- modal 1 end -->

    <section class="hero-section">
        <div class="insert_box" style="height:30px"><h3>응급처치 행동요령</h3></div>
        <div class="insert_box"></div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-12">
                    <div class="owl-carousel owl-theme">
                        <c:forEach items="${list}" var="eLDto">
                            <div class="owl-carousel-info-wrap item">
                                <a class="go_content" id="${eLDto.emer_list_no}">
                                    <img src="/image/water1.jpg" class="owl-carousel-image img-fluid" alt="">
                                    <div class="owl-carousel-info">
                                        <h4 class="mb-2">
                                                ${eLDto.emer_list_title}
                                            <img src="/image/high1.jpg" class="owl-carousel-verified-image img-fluid" alt="">
                                        </h4>
                                        <span class="badge">${eLDto.emer_list_tag1}</span>
                                        <span class="badge">${eLDto.emer_list_tag2}</span>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="insert_box"></div>
    <div class="modal_box"></div>
</main>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    $(function () {
        $(".go_content").click(function () {
            $("#modal_" + this.id).css("visibility", "visible");
            $("#modal_" + this.id).css("opacity", "1");
            $("#modal_" + this.id).css("transition", "all 1s");
            $("#modal_" + this.id).css("display", "flex");
            $(".hero-section").css("visibility", "hidden");
            $(".hero-section").css("opacity", "0");
            $(".hero-section").css("transition", "all 0.3s");
            $(".modal_box").css("display", "flex");
        });

        $(".modal_cancle").click(function () {
            $(".modal_screen").css("visibility", "hidden");
            $(".modal_screen").css("opacity", "0");
            $(".modal_screen").css("transition", "all 0.5s");
            $(".modal_screen").css("display", "none");
            $(".hero-section").css("visibility", "visible");
            $(".hero-section").css("opacity", "1");
            $(".hero-section").css("transition", "all 0.5s");
            $(".modal_box").css("display", "none");
        });
    });
</script>

<!-- JAVASCRIPT FILES -->
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/owl.carousel.min.js"></script>
<script src="/js/custom.js"></script>

<%@ include file="../footer/footer.jsp" %>
</body>
</html>
