<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- jstl 가져오기 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 여러 기능이 있는 함수 가져오기 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
 
<!-- Context-Path 값을 내장객체 변수로 저장 -->
<!-- controller라는 context-path를 저장하고 있는 내장객체 : pageContext.request.contextPath -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
 
<!-- Spring Security에서 제공하는 태그라이브러리 -->
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!-- Spring Security에서 제공하는 계정정보(SecurityContext 안에 계정정보 가져오기) -->
<!-- 로그인한 계정정보 : MemberUser(mvo) -->
<!-- MemberUser(mvo)안에 Member 안에 있는 memId를 꺼내서 사용할 거임 : mvo.member.memId -->
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
<!-- 권한 정보 -->
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}" />

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
         <security:authorize access="isAnonymous()">
           <ul class="nav navbar-nav navbar-right">
                 <li><a href="${contextPath}/loginForm.do"><span class="glyphicon glyphicon-log-in"><span style="margin-left: 5px;">로그인</span></span></a></li>
                 <li><a href="${contextPath}/joinForm.do"><sapn class="glyphicon glyphicon-user"><span style="margin-left: 5px;">회원가입</span></sapn></a></li>                
            </ul>
         </security:authorize>
         
         <!-- 로그인/회원가입 했을 시 나타날 메뉴바 -->
         <security:authorize access="isAuthenticated()">
           <ul class="nav navbar-nav navbar-right">           
                  <li>
                  	<c:if test="${mvo.member.memProfile ne ''}">
	                  <!-- mvo.memProfile 이 빈 값(not equals)이 아니면 -->
	                  <img src="${contextPath}/resources/upload/${mvo.member.memProfile}" style="width:50px; height:50px;" class="img-circle">

	                </c:if>
	                
                  	<c:if test="${mvo.member.memProfile eq ''}">
	                  <!-- mvo.memProfile 이 빈 값이 아니면 -->
	                  <img src="${contextPath}/resources/images/default.png" style="width:50px; height:50px;" class="img-circle">
	                 </c:if>
	                 ${mvo.member.memId}님 WELCOME
	                 
	                 [
	                 <security:authorize access="hasRole('ROLE_USER')">
	                 	U
	                 </security:authorize>
	                 <security:authorize access="hasRole('ROLE_MANAGER')">
	                 	M
	                 </security:authorize>
	                 <security:authorize access="hasRole('ROLE_ADMIN')">
	                 	A
	                 </security:authorize>
	                 ]
	                 
<%--                
	                 [
	                 	<!-- 
	                 		권한 정보 띄우기 
	                 		- 회원이 가진 권한의 리스크만큼 반복문을 돌면서 꺼내기
	                 		- session에 저장된 mvo에서 authList를 꺼내와서 그 안에 auth vo를 반복문 변수로 받아
	                 			-> auth VO의 auth 값이 ROLE_USER 면 'U'
	                 			-> ROLE_MANAGER 면 'M'
	                 			-> ROLE_ADMIN 면 'A'
	                 	-->
	                 	<c:forEach items="${mvo.authList}" var="auth">
	                 		<c:choose>
		                 		<c:when test="${auth.auth eq 'ROLE_USER'}">
		                 			U		                 		
		                 		</c:when>
		                 		<c:when test="${auth.auth eq 'ROLE_MANAGER'}">
		                 			M		                 		
		                 		</c:when>
		                 		<c:when test="${auth.auth eq 'ROLE_ADMIN'}">
		                 			A		                 		
		                 		</c:when>
	                 		</c:choose>
	                 	</c:forEach>
	                 	
	                 ]
 --%> 	                 
	         
	                 
                  </li>
                  <li><a href="${contextPath}/updateForm.do"><span class="glyphicon glyphicon-pencil"> 회원정보 수정</span></a></li>
                  <li><a href="${contextPath}/imgForm.do"><span class="glyphicon glyphicon-upload"> 프로필사진 등록</span></a></li>
                  <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"> 로그아웃</span></a></li>
            </ul>
         </security:authorize>
         
         
       </div>
     </div>
   </nav>
 <script type="text/javascript">
 	// CSRF 토큰 이름 가져오기
 	var csrfHeaderName = "${_csrf.headerName}";
 	// CSRF 토큰 값 가져오기
 	var csrfTokenValue = "${_csrf.token}";
 	
 	function logout(){
 		$.ajax({
 			url : "${contextPath}/logout",
 			type : "post",
 			beforeSend : function(xhr){
 				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
 			},
 			success : function(){
 				location.href = "${contextPath}/"
 			},
 			error : function(){
 				alert("error");
 			}
 		});
 	}
 	
 </script>

</body>
</html>