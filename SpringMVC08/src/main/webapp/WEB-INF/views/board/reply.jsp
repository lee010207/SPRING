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
				<form id="frm" method="post">
					<!-- 페이지에 대한 정보(현재페이지, 한페이지에 보여줄 게시글 수) -->
					<input type="hidden" name="page" value="${cri.page}"> 
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					
					<!-- 부모글의 게시글 번호 -->
					<input id="idx" type="hidden" name="idx" value="${vo.idx}"> 
					<input id="memId" type="hidden" name="memId" value="${m.memId}">
					
					
					<div class="form-group">
						<label>제목</label> 
						<input value="<c:out value='${vo.title}'/>"
							id="title" type="text" name="title" class="form-control">
					</div>
					<div class="form-group">
						<label>댓글</label>
						<textarea id="content" class="form-control" name="content" rows="10" cols=""
							placeholder="댓글을 입력하세요"></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input id="writer" type="text" name="writer"
							class="form-control" value="${m.memName}" readonly="readonly">
					</div>
					<button data-btn="reply" type="button" class="btn btn-default btn-sm">등록</button>
					<button data-btn="reset" type="button" class="btn btn-default btn-sm">취소</button>
					<button data-btn="list" type="button" class="btn btn-default btn-sm">목록</button>
				</form>

			</div>
			<div class="panel-footer">글쓰기</div>
		</div>
	</div>
	<script type="text/javascript">
		// 링크처리
		$(document).ready(function(){
			$("button").on("click", function(e){
				
				var formData = $("#frm");
				var btn = $(this).data("btn");
			
				if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					formData.find("#idx").remove();
					formData.attr("method","get");
					
					formData.find("#memId").remove();
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
					
				}else if(btn == "reply"){
					formData.attr("action", "${cpath}/board/reply");
				}else if(btn == "reset"){
					formData[0].reset();
					return; // 함수는 끝내는 키워드 
					// reset일 때는 submit이 안되고 reset 여기서 끝나야 함
				}
				// form태그 제출
				formData.submit();
				
			})
		});

	
	</script>
</body>
</html>