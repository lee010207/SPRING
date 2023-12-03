<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>
		<h2>SpringMVC05</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Board</div>
			<div class="panel-body">
			<table class="table table-bordered table-hover" id="boardList">
				<tr class="info">
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<tbody id="view">
					<!-- 비동기방식으로 가져온 게시글을 나오게 할 부분 -->
					<!-- 영역을 따로 분리, 구분하고 싶을 때 : tbody 사용 -->
				</tbody>
				
				<!-- 로그인을 해야 글쓰기 버튼이 생김 -->
				<c:if test="${not empty mvo}">
				<tr>
					<td colspan="5">
						<button onclick="goForm()" class="btn btn-primary btn-sm">글쓰기</button>
					</td>
				</tr>
				</c:if>
			</table>
			</div>
			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display : none">
				<form id="frm">
				<!--  로그인한 회원 아이디 정보도 함께 보내주기 for 회원제 게시판 -->
				<input type="hidden" name="memId" value="${mvo.memId}">	
				
					<table class="table">
						<tr>
							<td>제목</td>
							<td><input type="text" name="title" class="form-control"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" name="content" row="7" cols=""></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input readonly="readonly" value="${mvo.memName}" type="text" name="writer" class="form-control"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
								<button id="fclear" type="reset" class="btn btn-danger btn-sm">지우기</button>
								<button onclick="goList()" class="btn btn-info btn-sm">목록</button>
							</td>
						</tr>
					</table>
				</form>

			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
	
	<script type="text/javascript">
		// ajax에서도 post방식으로 데이터를 보내기 위해서는
		// csrf 토큰값을 전달해야 함
		
		// token 이름, 값 가져오기
		var csrfHeaderName = "${_csrf.headerName}";
		// ajax(비동기통신)에서 csrf의 이름을 사용할 때는 parameterName이 아니라 headerName 사용
		var csrfTokenValue = "${_csrf.token}";
		
		
		$(document).ready(function(){
			// 페이지가 열릴 때 바로 실행되게 만들어주기
			// HTML이 다 로딩되고나서 아래 코드 실행해라
			loadList();
		});
		
		
		function loadList(){
			// 비동기 방식으로 게시글 리스트 가져오기
			// ajax : 요청URL, 어떻게 데이터 받을지, 요청방식 등 ... -> 객체형태로 : {}(JSON 형식)
			// success 시 함수(makeView)를 실행 : ajax로 요청하고 나서 결과를 받아와서 끝나고(돌아와서) 실행하는 함수 -> 콜백함수
			$.ajax({
				url :"board/all",
				type :"get",
				dataType :"json",
				success : makeView,  // 콜백함수
				error : function(){
					alert("error");
				}
			});
		}
		
		function makeView(data){
			// 서버로부터 비동기 통신을 하고 나서 성공하면 실행될 함수
			var	listHtml = "";
			
			// jquery 반복문
			// 몇번 , data의 개수만큼 반복할건데 한번 반복할때마다 실행시키고 싶은 함수 작성
			// data : 게시글 전체 정보를 가지고 있는 데이터
			// data에 있는 객체를 하나씩 꺼내서 객체에다 담음 : obj
			$.each(data, function(index, obj){
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td id='t" + obj.idx + "'>" 
				listHtml += "<a href='javascript:goContent(" + obj.idx + ")'>"+ obj.title +"</a>"; 
				listHtml += "</td>";
				listHtml += "<td id='w" + obj.idx + "'>" + obj.writer + "</td>";
				listHtml += "<td>" + obj.indate + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "</tr>";
				
				// 상세보기 화면
				listHtml += "<tr id='c" + obj.idx + "' style='display:none'>";
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				listHtml += "<textarea id='ta" + obj.idx + "' readonly rows='5' class='form-control'>";
				// listHtml += obj.content;
				listHtml += "</textarea>";

				// 내가 쓴 글일 때만 수정 , 삭제 가능
				// 조건문 안에서 EL식을 쓰고 싶다면 문자열로 감싸줘야함!
				// 로그인한 사람의 아이디 = 게시글의 아이디가 일치할 때만 수정 삭제 버튼을 보여주겠다
				if("${mvo.memId}" == obj.memId){
					// 수정 삭제 화면
					listHtml += "<br>";
					listHtml += "<span id='ub" + obj.idx + "'>";
					listHtml += "<button onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정</button></span> &nbsp";
					listHtml += "<button onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp";
					
				}else{
					// 다른 글도 수정, 삭제 버튼은 나오는데 작동을 안하게 함 : button 태그에 disabled 속성 주기
					listHtml += "<br>";
					listHtml += "<span id='ub" + obj.idx + "'>";
					listHtml += "<button disabled onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-sm btn-success'>수정</button></span> &nbsp";
					listHtml += "<button disabled onclick='goDelete(" + obj.idx + ")' class='btn btn-sm btn-warning'>삭제</button> &nbsp";
					
				}
				
				listHtml += "</td>";
				listHtml += "</tr>";
				
			});

			$("#view").html(listHtml);

			goList();
		}
		// goForm 함수를 만들어서 view는 감추고 wform은 보이게
		function goForm() {
			$('#boardList').css("display", "none");
			$('#wform').css("display", "table-row");
		}

		function goList() {
			$('#boardList').css("display", "table-row");
			$('#wform').css("display", "none");
		}

		function goInsert() {
			// 게시글 등록기능 : 비동기 방식
			// form 태그에 id값을 줘서 form태그 안에 있는 input 태그에 입력되는 값을 한번에 가져옴(직렬화)
			// ex) title="안녕"&content="반가워"&writer="호두아빠"
			var fdata = $("#frm").serialize();
			$.ajax({
				// 통신에 성공하고 받아올 데이터가 없음 -> dataType 명시 X
				// -> 게시글을 다시 불러오는 기능 실행(loadList())
				// 요청할떄 보낼 데이터가 있음 -> data:보내줄 데이터
				url : "board/new",
				type : "post",
				data : fdata,
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : loadList,
				error : function() {
					alert("error");
				}

			});

			$("#fclear").trigger("click");
		}

		function goContent(idx) {
			if ($("#c" + idx).css("display") == "none") {
				// display 속성값을 가져옴
				
				// 원래 : 누르면 기존에 있는 영역(안보이던)을 보이게 해줌
				// -> 누르면 새로 띄워주게(내용이 보이게) 만들기

				$.ajax({
					url : "board/" + idx,
					// pathvariable방식 : 경로에다가 값을 붙여 보내는 방식
					type : "get",
					dataType : "json",
					success : function(data){
						// data = Board vo
						$("#ta" + idx).val(data.content);
					},
					error : function(){
						alert("error");
					}
					
				});
				
				$("#c" + idx).css("display", "table-row");

			} else {
				$("#c" + idx).css("display", "none");

				$.ajax({
					url : "board/count/" + idx,
					type : "put",
					beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success : loadList,
					error : function() {
						alert("error");
					}

				});
			}

		}

		function goDelete(idx) {
			$.ajax({
				url : "board/" + idx,
				// url이름을 똑같이(상세보기 기능이랑) 만들어줌
				// but, 요청방식이 다름 : delete
				data : {"idx" : idx},
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : "delete",
				success : loadList,
				error : function() {
					alert("error");
				}
			});
		}

		function goUpdateForm(idx) {
			// 수정 버튼을 클릭하면 textarea(내용), 제목, 작성자 부분을 input태그로 바꿔주기
			$("#ta" + idx).attr("readonly", false);
			var title = $("#t" + idx).text();
			var newTitle = "<input id='nt"+ idx +"' value='" + title + "'type='text' class='form-control'>";

			$("#t" + idx).html(newTitle);

			var writer = $("#w" + idx).text();
			var newWriter = "<input id='nw"+ idx +"' value='" + writer + "'type='text' class='form-control'>";

			$("#w" + idx).html(newWriter);

			var newBtn = "<button onclick='goUpdate(" + idx
					+ ")' class='btn btn-primary btn-sm'>완료</button>";
			$("#ub" + idx).html(newBtn);

		}

		function goUpdate(idx) {
			var title = $("#nt" + idx).val();
			var writer = $("#nw" + idx).val();
			var content = $("#ta" + idx).val();

			$.ajax({
				url : "board/update",
				data : JSON.stringify({
					"idx" : idx,
					"title" : title,
					"writer" : writer,
					"content" : content
				}),
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : "put",
				contentType : "application/json;charset=utf-8",
				success : loadList,
				error : function() {
					alert("error");
				}
			});
		}
	</script>
</body>
</html>