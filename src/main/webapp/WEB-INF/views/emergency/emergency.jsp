<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>emergency</title>
    <!-- CSS FILES -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&family=Sono:wght@200;300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/emergency/bootstrap.min.css">
    <link rel="stylesheet" href="/css/emergency/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/emergency/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/emergency/owl.theme.default.min.css">
    <link href="/css/emergency/templatemo-pod-talk.css" rel="stylesheet">
    <link href="/css/emergency/content.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/css/emergency/modal.css">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/top.css">
    <style>
        .title-centered {
            text-align: center;
            margin: 20px 0;
        }
        img{
            height:400px;
            border-radius:15px;
            padding-right:0 !important;
        }
    </style>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-00CXGT1Y2K');
    </script>
</head>
<body>
<header>
    <%@ include file="../top/top.jsp" %>
</header>
<main>
    <!-- modal 1 start -->
    <c:forEach items="${modal_list}" var="mList">
        <div class="modal_screen" id="modal_${mList.emer_no}">
            <a class="modal_cancle"></a>
            <div class="modal_screen2">
                <div class="modal_title">
                    <h3>${mList.title}</h3>
                    <p>${mList.content}</p>
                </div>
                <div class="modal_content">
                    <ul class="modal_list">
                        <li class="modal_item">
                            <div class="modal_step">Step 01</div>
                            <div class="modal_text">${mList.step_cont1}</div>
                            <img src="${mList.step_img1}" class="modal_img">
                        </li>
                        <li class="modal_item">
                            <div class="modal_step">Step 02</div>
                            <div class="modal_text">${mList.step_cont2}</div>
                            <img src="${mList.step_img2}" class="modal_img">
                        </li>
                        <li class="modal_item">
                            <div class="modal_step">Step 03</div>
                            <div class="modal_text">${mList.step_cont3}</div>
                            <img src="${mList.step_img3}" class="modal_img">
                        </li>
                        <li class="modal_item">
                            <div class="modal_step">Step 04</div>
                            <div class="modal_text">${mList.step_cont4}</div>
                            <img src="${mList.step_img4}" class="modal_img">
                        </li>
                        <!-- Additional steps as needed -->
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
    <!-- modal 1 end -->
    <section class="hero-section">
        <div class="insert_box title-centered"><h3>응급처치 행동요령</h3></div>
        <div class="insert_box"></div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-12">
                    <div class="owl-carousel owl-theme">
                        <c:forEach items="${list}" var="eLDto">
                            <div class="owl-carousel-info-wrap item" style="height:300px;">
                                <a class="go_content" id="${eLDto.emer_list_no}">
                                    <img src="${eLDto.emer_list_img}" class="owl-carousel-image img-fluid" alt="">
                                    <div class="owl-carousel-info">
                                        <h4 class="mb-2">
                                                ${eLDto.emer_list_title}
                                            <img src="/image/verified.png" class="owl-carousel-verified-image img-fluid" alt="">
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
<script>
    $(function() {
        $(".go_content").click(function() {
            var modalId = "#modal_" + this.id;
            $(modalId).css("visibility", "visible");
            $(modalId).css("opacity", "1");
            $(modalId).css("display", "flex");

            $(".hero-section").css("visibility", "hidden");
            $(".hero-section").css("opacity", "0");
            $(".modal_box").css("display", "flex");
        });

        $(".modal_cancle").click(function() {
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
</body>
<%@ include file="../footer/footer.jsp" %>
</html>
