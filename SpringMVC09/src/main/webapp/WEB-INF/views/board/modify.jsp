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
		<h2>SpringMVC09</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
				<form id="frm">
					<table class="table table-bordered table-hover">
						<tr>
							<td>번호</td>
							<td><input id="idx" type="text" class="form-control" name="idx" value="${vo.idx}" readonly="readonly"></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input id="title" value="<c:out value='${vo.title}'/>" type="text" class="form-control" name="title"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea id="content" class="form-control" rows="10" cols="" name="content"><c:out value="${vo.content}"/></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input id="writer" type="text" class="form-control" name="writer" value="${vo.writer}" readonly="readonly"></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<!-- 로그인한 사람의 아이디랑 게시글 작성한 아이디가 같을 때만 수정/삭제 가능 : 내 글만 수정/삭제 가능 -->
								<c:if test="${not empty m && m.memId eq vo.memId}">
									<button data-btn="modify" type="button" class="btn btn-xs btn-primary">완료</button>
									<button data-btn="remove" type="button" class="btn btn-xs btn-danger">삭제</button>
								</c:if>
								<c:if test="${empty m or m.memId ne vo.memId}">
									<button disabled="disabled" type="button" class="btn btn-xs btn-primary">완료</button>
									<button disabled="disabled" type="button" class="btn btn-xs btn-danger">삭제</button>
								</c:if>
								<button type="button" data-btn="list" class="btn btn-xs btn-default">목록</button>
							</td>
						</tr>
					</table>
					<!-- 검색 type과 keyword를 넘기기 위한 부분 추가 : 페이징 시 검색 정보 유지 -->
					<input type="hidden" name="type" value="${cri.type}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
					
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
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
				// 현재 클릭한 버튼의 요소값을 가져옴  ex) reply, modify ... 
				// alert(btn);
		
				// 가져온 버튼값에 따라 어떤 URL 값으로 이동할 지 action값을 채워주는 조건문
				if(btn == "remove"){
					formData.attr("action", "${cpath}/board/remove");
					formData.attr("method", "get");
					
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
					
				}else if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					// 목록으로 돌아가기 : idx를 가지고 갈 필요가 없음
					// idx를 없애주는 작업이 필요함
					formData.find("#idx").remove();
					formData.find("#title").remove();
					formData.find("#content").remove();
					formData.find("#writer").remove();
					
					formData.attr("method", "get");
				}else if(btn == "modify"){
					formData.attr("action", "${cpath}/board/modify");
					formData.attr("method", "post");
				}
				// form태그 제출
				formData.submit();
				
			})
		});
	
	</script>
</body>
</html>