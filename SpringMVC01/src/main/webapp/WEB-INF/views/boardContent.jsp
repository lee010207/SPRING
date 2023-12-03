<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<% pageContext.setAttribute("newlineChar","\n"); %>
	<%-- \n이 발견될 때마다 <br> 넣어주는 기능 만들어주기 --%>
	<div class="container">
		<h2>SpringMVC01</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
			
				<table class="table">
					<tr>
						<td>제목</td>
						<td>${vo.title }</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							${fn:replace(vo.content, newlineChar,"<br>") }
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${vo.writer }</td>
					</tr>						
					<tr>
						<td>작성일</td>
						<td>${fn:split(vo.indate," ")[0] }</td>
						<!-- vo.indate를 띄어쓰기 기준으로 잘라내고 잘라낸걸 배열로 담아주니까 맨 앞에 있는 걸 쓰겠다! -->
					</tr>						
					<tr>
						<td colspan="2" align="center">
							<a href="../boardUpdateForm.do/${vo.idx}" class="btn btn-success btn-sm">수정</a>
							<a href="../boardDelete.do/${vo.idx}" class="btn btn-danger btn-sm">삭제</a>
							<a href="../boardList.do" class="btn btn-info btn-sm">목록</a>
							<!-- 
								http://localhost:8081/controller/boardContent.do/boardList.do  : 에러 발생
								-> pathVariable 방식으로 바꾸면서 boardContent.do (폴더)안으로 들어오는 개념으로 인식
								-> 한번 밖으로 나가줘야 돼 : ../ 붙여주기!
							
							-->
						</td>
					</tr>						
				</table>
					
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
</body>
</html>