<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!-- jstl 가져오기 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 여러 기능이 있는 함수 가져오기 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
 
<!-- Context-Path 절대경로 -->
<c:set var="cpath" value="${pageContext.request.contextPath }" />    

<!DOCTYPE HTML>
<!--
	Radius by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
--><html><head><title>Radius by TEMPLATED</title><meta charset="utf-8"><meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1"><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="${cpath}/./resources/assets/css/main.css"></head><body>

		<!-- Header -->
			<header id="header"><div class="inner">
					<div class="content">
						<h1>D.A.Y</h1>
						<h2>A fully responsive masonry-style<br>
						portfolio template.</h2>
						<a href="#" class="button big alt"><span>Let's Go</span></a>
					</div>
					<a href="#" class="button hidden"><span>Let's Go</span></a>
				</div>
			</header><!-- Main --><div id="main">
				<div class="inner">
					<div class="columns">

						<!-- Column 1 (horizontal, vertical, horizontal, vertical) -->
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic01.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic02.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic03.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic04.jpg" alt="" width="533" height="800"></a>
							</div>

						<!-- Column 2 (vertical, horizontal, vertical, horizontal) -->
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic06.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic05.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic08.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic07.jpg" alt="" width="800" height="533"></a>
							</div>

						<!-- Column 3 (horizontal, vertical, horizontal, vertical) -->
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic09.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic12.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic11.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic10.jpg" alt="" width="533" height="800"></a>
							</div>

						<!-- Column 4 (vertical, horizontal, vertical, horizontal) -->
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic13.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic14.jpg" alt="" width="800" height="533"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic15.jpg" alt="" width="533" height="800"></a>
							</div>
							<div class="image fit">
								<a href="detail1.html"><img src="${cpath}/./resources/images/pic16.jpg" alt="" width="800" height="533"></a>
							</div>

					</div>
				</div>
			</div>

		<!-- Footer -->
			<footer id="footer"><a href="#" class="info fa fa-info-circle"><span>About</span></a>
				<div class="inner">
					<div class="content">
						<h3>Vestibulum hendrerit tortor id gravida</h3>
						<p>In tempor porttitor nisl non elementum. Nulla ipsum ipsum, feugiat vitae vehicula vitae, imperdiet sed risus. Fusce sed dictum neque, id auctor felis. Praesent luctus sagittis viverra. Nulla erat nibh, fermentum quis enim ac, ultrices euismod augue. Proin ligula nibh, pretium at enim eget, tempor feugiat nulla.</p>
					</div>
					<div class="copyright">
						<h3>Follow me</h3>
						<ul class="icons"><li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
						</ul></div>
				</div>
			</footer><div class="copyright">
			Design by: <a href="https://templated.co/">TEMPLATED.CO</a>
		</div>

		<!-- Scripts -->
			<script src="${cpath}/./resources/assets/js/jquery.min.js"></script><script src="${cpath}/./resources/assets/js/skel.min.js"></script><script src="${cpath}/./resources/assets/js/util.js"></script><script src="${cpath}/./resources/assets/js/main.js"></script></body></html>
