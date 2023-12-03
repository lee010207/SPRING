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
	<div class="container">
		<h2>SpringMVC01 : 동기방식</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
			<table class="table table-bordered table-hover">
				<tr class="info">
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<!-- model안에 있는 list를 jstl을 활용하여 출력하기 -->
				<!-- model은 request안에 있음 -->
				<c:forEach items="${list }" var="info" varStatus="i">
					<tr>
					<td>${i.count}</td>
					<td><a href="boardContent.do/${info.idx}">${info.title }</a></td>
					<td>${info.content }</td>
					<td>${info.writer }</td>
					<td>${fn:split(info.indate," ")[0] }</td>
					<td>${info.count }</td>
					</tr>
				</c:forEach>
			</table>
			
			<a href="boardForm.do" class="btn btn-primary btn-sm">글쓰기</a>
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
</body>
</html>