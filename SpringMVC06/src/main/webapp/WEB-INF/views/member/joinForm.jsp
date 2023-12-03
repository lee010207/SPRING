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
		<h2>SpringMVC06</h2>
		<div class="panel panel-default">
			<div class="panel-heading">회원가입</div>
			<div class="panel-body">
				<form action="${contextPath}/join.do" method="post">
				<!--  
					이제는 서버로 단순히 회원가입 정보만 전달하는 것이 아니라
					서버에서 발행한 토큰도 전달해야 회원가입이 가능함
				 -->
				 <!-- 
				 	_csrf : 내부적으로 존재하는 보안객체
				 		-> 이름값(name) , 토큰값(value)
				  -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
					<input type="hidden" name="memPw" id="memPw" value="">
					<table style="text-align: center; border:1px solid #dddddd" class="table table-bordered">
						<tr>
							<td style="width:110px; vertical-align: middle;">아이디</td>
							<td><input type="text" required="required" name="memId" id="memId" class="form-control" maxlength="20" placeholder="아이디를 입력하세요"></td>
							<td style="width:110px;"><button type="button" onclick="idCheck()" class="btn btn-sm btn-primary">중복확인</button></td>
						</tr>
						<tr>
							<td style="width:110px; vertical-align: middle;">비밀번호</td>
							<td colspan="2"><input type="password" name="memPw1" id="memPw1" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width:110px; vertical-align: middle;">비밀번호 확인</td>
							<td colspan="2"><input type="password" onkeyup="pwCheck()" name="memPw2" id="memPw2" class="form-control" maxlength="20" placeholder="비밀번호를 확인하세요"></td>
						</tr>
						<tr>
							<td style="width:110px; vertical-align: middle;">이름</td>
							<td colspan="2"><input type="text" onkeyup="pwCheck()" name="memName" id="memName" class="form-control" maxlength="20" placeholder="이름을 입력하세요"></td>
						</tr>	
						<tr>
							<td style="width:110px; vertical-align: middle;">나이</td>
							<td colspan="2"><input type="number" name="memAge" id="memAge" class="form-control" maxlength="20" placeholder="나이를 입력하세요"></td>
						</tr>											
						<tr>
							<td style="width:110px; vertical-align: middle;">성별</td>
							<td colspan="2">
								<div class="form-group" style="text-align:center; margin:0 auto;">
									<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-basic active">
											<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여자" checked="checked">여
										</label>
										<label class="btn btn-basic active">
											<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자">남
										</label>
									</div>
								</div>
							</td>
						</tr>											
						<tr>
							<td style="width:110px; vertical-align: middle;">이메일</td>
							<td colspan="2"><input type="email" name="memEmail" id="memEmail" class="form-control" maxlength="50" placeholder="이메일을 입력하세요"></td>
						</tr>
						
						<!-- 원래는 회원가입하면 관리자가 권한을 부여해주는 게 맞음 -->
						<!-- 권한 체크박스 -->
						<tr>
							<td style="width:110px; vertical-align: middle;">권한</td>
							<td colspan="2">
								<input type="checkbox" name="authList[0].auth" value="ROLE_USER">ROLE_USER
								<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER">ROLE_MANAGER
								<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN">ROLE_ADMIN
							</td>
						</tr>
																	
						<tr>
							<td colspan="3">
							<span id="pwMs" style="color:red;"></span>
							<input type="submit" class="btn btn-success btn-sm pull-right" value="회원가입 완료">
							<input type="reset" class="btn btn-warning btn-sm pull-right" value="취소">
							</td>
						</tr>											
					</table>
				</form>
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
	
	  <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div id="checkType" class="modal-content">
	        <div class="modal-header panel-heading">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">아이디 중복 검사</h4>
	        </div>
	        <div class="modal-body">
	          <p id="checkMs"></p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	  
	  <!-- 회원가입 실패 시 띄워줄 Modal -->
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
		function idCheck(){
			
			var id = $("#memId").val();
			$.ajax({
				url:"${contextPath}/idCheck.do",
				data:{"memId": id},
				type:"get",
				success:function(data){
					console.log(data);
					// 중복유무 확인 -> data = 1 : 사용가능 / = 0 : 사용불가능
					if(data > 0){
						$("#checkMs").text("사용 가능한 아이디 입니다.");
						$("#checkType").attr("class","modal-content panel-success");
					}else{
						$("#checkMs").text("사용할 수 없는 아이디 입니다.");
						$("#checkType").attr("class","modal-content panel-warning");
					}
					
					$("#myModal").modal("show");
				},
				error:function(){
					alert("error");
				}
				
			});
			
		}
		
		
		function pwCheck(){
			var memPw1 = $("#memPw1").val();
			var memPw2 = $("#memPw2").val();
			
			if(memPw1 == memPw2){
				$("#pwMs").text("");
				// 일치했을 때 비밀번호 데이터를 넘길 input 태그(안보이게 해놓은 : hidden)에 값을 넘겨줌
				$("#memPw").val(memPw1);
			}else{
				$("#pwMs").text("비밀번호가 일치하지 않습니다.");
			}
			
		}
		
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