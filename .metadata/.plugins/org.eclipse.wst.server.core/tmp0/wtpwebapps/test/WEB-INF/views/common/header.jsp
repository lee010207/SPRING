<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- jstl 가져오기 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 여러 기능이 있는 함수 가져오기 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
 
<!-- Context-Path 값을 내장객체 변수로 저장 -->
<!-- controller라는 context-path를 저장하고 있는 내장객체 : pageContext.request.contextPath -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 여러 페이지들에 공통적으로 들어가는 것(ex. 메뉴바)을 모아둔 파일 : common -->
 
    <!-- 메뉴바 -->
   <nav class="navbar navbar-default">
     <div class="container-fluid">
       <div class="navbar-header">
         <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>                        
         </button>
         <a class="navbar-brand" href="${contextPath}/">Spring</a>
       </div>
       <div class="collapse navbar-collapse" id="myNavbar">
         <ul class="nav navbar-nav">
         <!-- href(url) 작성 시, "/"를 생략하는 순간 앞에 "/controller/"(contextPath)가 생략되어 있는 것과 같음 -->
         <!-- 
               < href="/" 사용하고 싶을 때...>
              1. "/controller/"
               2. 내장객체 변수로 저장한 Context-Path 값을 불러옴 ${contextPath}    
                       
              < contextPath 값을 아는 방법 > 
               1. package 세번째 이름 / 
               2. Servers 파일 - server.xml 파일에 path로 저장되어 있음   -->
           <li class="active"><a href="${contextPath}/">메인</a></li>
           
           <li><a href="boardMain.do">게시판</a></li>
         </ul>
         
         
         
         <!-- 로그인/회원가입 안 했을 시 나타날 메뉴바 -->
         <c:if test="${empty mvo}">
           <ul class="nav navbar-nav navbar-right">
                 <li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in"><span style="margin-left: 5px;">로그인</span></span></a></li>
                 <li><a href="${contextPath}/joinForm.do"><sapn class="glyphicon glyphicon-user"><span style="margin-left: 5px;">회원가입</span></sapn></a></li>                
            </ul>
         </c:if>
         
         <!-- 로그인/회원가입 했을 시 나타날 메뉴바 -->
         <c:if test="${not empty mvo}">
           <ul class="nav navbar-nav navbar-right">           
                  <li>
                  	<c:if test="${mvo.memProfile ne ''}">
	                  <!-- mvo.memProfile 이 빈 값(not equals)이 아니면 -->
	                  <img src="${contextPath}/resources/upload/${mvo.memProfile}" style="width:50px; height:50px;" class="img-circle">
	                  	${mvo.memId}님 WELCOME
	                </c:if>
	                
                  	<c:if test="${mvo.memProfile eq ''}">
	                  <!-- mvo.memProfile 이 빈 값이 아니면 -->
	                  <img src="${contextPath}/resources/images/default.png" style="width:50px; height:50px;" class="img-circle">
	                  	${mvo.memId}님 WELCOME
	                 </c:if>
                  </li>
                  <li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-pencil"> 회원정보 수정</span></a></li>
                  <li><a href="${contextPath}/imgForm.do"><span class="glyphicon glyphicon-upload"> 프로필사진 등록</span></a></li>
                  <li><a href="${contextPath}/logout.do"><span class="glyphicon glyphicon-log-out"> 로그아웃</span></a></li>
            </ul>
         </c:if>
         
         
       </div>
     </div>
   </nav>
 

</body>
</html>