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
				<table class="table table-bordered table-hover">
					<tr>
						<td>번호</td>
						<td>${vo.idx}</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><c:out value="${vo.title}"/></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" readonly="readonly" rows="10" cols="" ><c:out value="${vo.content}"/></textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${vo.writer}</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;">
						<!-- 로그인을 안했으면 (세션에 m이 저장 되지 않았으면) 답글, 수정이 안됨 -->
							<c:if test="${not empty m}">
								<button data-btn="reply" class="btn btn-xs btn-primary">답글</button>
								<button data-btn="modify" class="btn btn-xs btn-warning">수정</button>
								
							</c:if>
							<c:if test="${empty m}">
								<button disabled="disabled" class="btn btn-xs btn-primary">답글</button>
								<button disabled="disabled" class="btn btn-xs btn-warning">수정</button>
								
							</c:if>
							<button data-btn="list" class="btn btn-xs btn-default">목록</button>
						</td>
					</tr>
				</table>
				<form id="frm" action="" method="get">
					<input type="hidden" name="idx" value="${vo.idx}">
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					
					<!-- 검색 type과 keyword를 넘기기 위한 부분 추가 : 페이징 시 검색 정보 유지 -->
					<input type="hidden" name="type" value="${cri.type}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
				</form>

			</div>
			<div class="panel-footer">글쓰기</div>
		</div>
	</div>
	<script type="text/javascript">
		// 링크처리
		$(document).ready(function(){
			$("button").on("click", function(e){
				
				// form태그에 접근
				var formData = $("#frm");
				var btn = $(this).data("btn");
				// 현재 클릭한 버튼의 요소값을 가져옴  ex) reply, modify ... 
				// alert(btn);
		
				// 가져온 버튼값에 따라 어떤 URL 값으로 이동할 지 action값을 채워주는 조건문
				if(btn == "reply"){
					formData.attr("action", "${cpath}/board/reply");
				}else if(btn == "modify"){
					formData.attr("action", "${cpath}/board/modify");
				}else if(btn == "list"){
					formData.attr("action", "${cpath}/board/list");
					// 목록으로 돌아가기 : idx를 가지고 갈 필요가 없음
					// idx를 없애주는 작업이 필요함
					formData.find("#idx").remove();
				}
				// form태그 제출
				formData.submit();
				
			})
		});
	
	</script>
</body>
</html>