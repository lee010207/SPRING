<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환영합니다!</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/header.jsp"></jsp:include>
		<h2>SpringMVC04</h2>
		<div class="panel panel-default">
			<div class="panel-heading">회원가입</div>
			<div class="panel-body">
				<form action="${contextPath}/login.do" method="post">
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<table style="text-align: center; border:1px solid #dddddd" class="table table-bordered">
						<tr>
							<td style="width:110px; vertical-align: middle;">아이디</td>
							<td><input type="text" name="memId" id="memId" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width:110px; vertical-align: middle;">비밀번호</td>
							<td><input required="required" type="password" name="memPw" id="memPw" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
						</tr>
						<tr>
							<td colspan="2">
							<input type="submit" class="btn btn-success btn-sm pull-right" value="로그인">
							<input type="reset" class="btn btn-warning btn-sm pull-right" value="취소">
							</td>
						</tr>											
					</table>
				</form>
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
	
	  
	  <!-- 로그인 상태를 띄워줄 Modal -->
	  <div class="modal fade" id="myMsg" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div id="msgType" class="modal-content">
	        <div class="modal-header panel-heading">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">${msgType}</h4>
	          <!-- 회원가입 실패 시 msgType과 msg를 보내서 모달창에 띄워줄거임 -->
	        </div>
	        <div class="modal-body">
	          <p id="">${msg}</p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	
	<script type="text/javascript">
		
		$(document).ready(function(){
			if(${not empty msgType}){
				// msgType에 뭔가 값이 있다 : 회원가입 시도를 했는데 실패했다
				if(${msgType eq "실패메세지"}){
					$("#msgType").attr("class", "modal-content panel-warning");
				}
				$("#myMsg").modal("show");
			}
		});
	</script>
</body>
</html>