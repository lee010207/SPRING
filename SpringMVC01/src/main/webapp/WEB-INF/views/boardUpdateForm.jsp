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
	<div class="container">
		<h2>SpringMVC01</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
			<form action="../boardUpdate.do" method="post">
				<input type="hidden" name="idx" value="${vo.idx}">
				<!-- 사용자는 입력하지 않고 숨겨서 값을 같이 보내야 할 때 : input 태그 hidden 사용! -->
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" class="form-control" value="${vo.title}"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" name="content" row="7" cols="">${vo.content}</textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="writer" class="form-control" value="${vo.writer}"></td>
					</tr>						
					<tr>
						<td colspan="2" align="center">
							<button type="submit" class="btn btn-success btn-sm">수정완료</button>
							<button type="reset" class="btn btn-danger btn-sm">지우기</button>
							<a href="../boardList.do" class="btn btn-info btn-sm">목록</a>
						</td>
					</tr>						
				</table>
			</form>			
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
</body>
</html>