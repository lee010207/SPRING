<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />    
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>

	<div class="card">
		<div class="card-header">
			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1>Spring MVC10</h1>
					<p>Java -> HTML -> CSS -> JS -> JSP&Servlet -> Spring framework -> Spring Boot</p>
				</div>
			</div>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-lg-2">
					<div class="card" style="min-height:500px; max-height:1000px;">
						<div class="card-body">
							<h4 class="card-title">GUEST</h4>
							<p class="card-text">회원님 환영합니다👻</p>
							<!-- 로그인 화면 -->
							<form action="">
								<div class="form-group">
									<label for="memID">아이디</label>
									<input name="memID" type="text" class="form-control" id="memId">
								</div>
								<div class="form-group">
									<label for="memPwd">비밀번호</label>
									<input name="memPwd" type="password" class="form-control" id="memPwd">
								</div>
								<button type="submit" class="form-control btn btn-sm btn-info">로그인</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="card" style="min-height:500px; max-height:1000px;">
					<!-- 게시글 목록 화면 -->
						<div class="card-body">
							<table class="table table-bordered table-hover">
								<thead>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</thead>
								<!-- fmt:formatDate 쓰려면 Date 타입이어야 함 -->
								<tbody>
									<c:forEach var="vo" items="${list}" varStatus="i">
										<tr>
											<td>${i.count}</td>
											<td><a href="${vo.idx}">${vo.title}</a></td>
											<td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/></td>
											<td>${vo.count}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="card" style="min-height:500px; max-height:1000px;">
					<!-- 글쓰기 / 상세보기 화면 -->
						<div class="card-body">
							<form id="regForm" action="${cpath}/register" method="post">
							
								<!-- 삭제 기능을 위한 idx값 넘겨주기 -->
								<input type="hidden" id="idx" name="idx" value="">
								
								<div class="form-group">
									<label for="title">제목</label>
									<input name="title" type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
								</div>
								<div class="form-group">
									<label for="content">내용</label>
									<textarea name="content" class="form-control" rows="7" cols="" id="content" placeholder="내용을 입력하세요"></textarea>
								</div>
								<div class="form-group">
									<label for="writer">작성자</label>
									<input name="writer" type="text" class="form-control" id="writer" placeholder="작성자를 입력하세요">
								</div>
								<div id="regDiv">
									<button type="button" data-oper="register" class="btn btn-sm btn-primary">글 등록</button>
									<button type="button" data-oper="reset" class="btn btn-sm btn-danger">취소</button>
								</div>
								
								<div id="updateDiv" style="display: none;">
									<span id="update">
									<button type="button" data-oper="updateForm" class="btn btn-xs btn-default">수정</button>
									</span>
									<button type="button" data-oper="remove" class="btn btn-xs btn-warning">삭제</button>
									<button type="button" data-oper="list" class="btn btn-xs btn-success">목록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card-footer">SPRING-YI</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var regForm = $("#regForm");
			
			$("button").on("click",function(){
				var oper = $(this).data("oper");
				// 클릭한 요소 자체의 data값을 가져오겠다 : oper이라고 이름붙여놓은 값
				if(oper == "register"){
					regForm.submit();
				}else if(oper == "reset"){
					regForm[0].reset();
				}else if(oper == "list"){
					// 페이지 다시 로드(새로고침)
					location.href = "${cpath}/list";
				}else if(oper == "remove"){
					var idx = regForm.find("#idx").val();
					location.href = "${cpath}/remove?idx="+idx;
					// idx값 붙여서 remove로 페이지(삭제기능 실행하는) 이동
				}else if(oper == "updateForm"){
					regForm.find("#title").attr("readonly", false);
					regForm.find("#content").attr("readonly", false);
					
					var upBtn = "<button onclick='goUpdate()' type='button' class='btn btn-sm btn-default'>수정완료</button>";
					$("#update").html(upBtn);
					
				}
			});
			
			// getList() : 전체 목록 띄워주기
			$("a").on("click", function(e){
				// a태그를 클릭하면 함수를 실행시킬건데 클릭한 요소를 매개변수로 넣어주겠다
				e.preventDefault();
				var idx = $(this).attr("href");
				$.ajax({
					url: "${cpath}/get",
					type:"get",
					data:{"idx" : idx},
					dataType:"json",
					success: printBoard,
					error: function(){ alert("error"); }
				});
				
			});
		});
		
		// 상세보기 화면 띄워주기
		function printBoard(vo){
			var regForm = $("#regForm");
			regForm.find("#title").val(vo.title);
			regForm.find("#content").val(vo.content);
			regForm.find("#writer").val(vo.writer);
			
			regForm.find("input").attr("readonly", true);
			regForm.find("textarea").attr("readonly", true);
			
			// 등록(글쓰기)버튼 대신 수정/삭제/목록 버튼 띄워주기
			$("#regDiv").css("display","none");
			$("#updateDiv").css("display", "block");
			
			regForm.find("#idx").val(vo.idx);
		}
		
		function goUpdate(){
			var regForm = $("#regForm");
			regForm.attr("action", "${cpath}/modify");
			regForm.submit();
		}
	</script>
</body>
</html>