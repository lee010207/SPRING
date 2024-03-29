<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
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
		<h2>SpringMVC08</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
				<form action="${cpath}/board/register" method="post">
				
				<input type="hidden" name="memId" value="${m.memId}">
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" name="content" rows="10" cols="" placeholder="글을 입력하세요"></textarea>					
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input type="text" name="writer" class="form-control" value="${m.memName}" readonly="readonly">				
					</div>
					<button type="submit" class="btn btn-default btn-sm">등록</button>
					<button type="reset" class="btn btn-default btn-sm">취소</button>
				</form>
			
			</div>
			<div class="panel-footer">글쓰기</div>
		</div>
	</div>
	<script type="text/javascript">

	
	</script>
</body>
</html>