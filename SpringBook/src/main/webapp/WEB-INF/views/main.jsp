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
		<h2>Spring Book</h2>
		<div class="panel panel-default">
			<div class="panel-heading">Book</div>
			<div class="panel-body">
			<table class="table table-bordered table-hover" id="bookList">
				<tr class="info">
					<th>번호</th>
					<th>제목</th>
					<th>작가</th>
					<th>출판사</th>
					<th>isbn</th>
					<th>보유도서수</th>
					<th>삭제</th>
					<th>수정</th>
				</tr>
				<tbody id="view">
					<!-- 비동기방식으로 가져온 게시글을 나오게 할 부분 -->
					<!-- 영역을 따로 분리, 구분하고 싶을 때 : tbody 사용 -->
				</tbody>
				
				<tr>
					<td colspan="9">
						<button onclick="goForm()" class="btn btn-primary btn-sm">도서등록</button>
					</td>
				</tr>
			</table>
			</div>
			<!-- 글쓰기 폼 -->
			<div class="panel-body" id="wform" style="display : none">
				<form id="frm">
					<table class="table">
						<tr>
							<td>제목</td>
							<td><input type="text" name="title" class="form-control"></td>
						</tr>
						<tr>
							<td>작가</td>
							<td><input type="text" class="form-control" name="author"></td>
						</tr>
						<tr>
							<td>출판사</td>
							<td><input type="text" name="company" class="form-control"></td>
						</tr>
						<tr>
							<td>isbn</td>
							<td><input type="text" name="isbn" class="form-control"></td>
						</tr>
						<tr>
							<td>보유도서수</td>
							<td><input type="text" name="count" class="form-control"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
								<button id="fclear" type="reset" class="btn btn-danger btn-sm">취소</button>
								<button onclick="goList()" class="btn btn-info btn-sm">리스트로 가기</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			
			<div class="panel-body" id="updateform" style="display : none">
				<table class="table">
				<input id="nn" type="hidden" name ="num">
					<tr>
						<td>제목</td>
						<td><input id="tt" readonly="readonly" type="text" name="title"
							class="form-control"></td>
					</tr>
					<tr>
							<td>작가</td>
							<td><input id="aa" readonly="readonly" type="text" class="form-control" name="author"></td>
						</tr>
						<tr>
							<td>출판사</td>
							<td><input id="cc" readonly="readonly" type="text" name="company" class="form-control"></td>
						</tr>
						<tr>
							<td>isbn</td>
							<td><input id="ii" readonly="readonly" type="text" name="isbn" class="form-control"></td>
						</tr>
						<tr>
							<td>보유도서수</td>
							<td><input id="hh" type="text" name="count" class="form-control"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="goUpdate()">수정</button>
								<button type="reset" id="fclear" class="btn btn-danger btn-sm">취소</button>
								<button onclick="goList()" class="btn btn-info btn-sm">리스트로 가기</button>
							</td>
						</tr>
				</table>
			</div>
			<div class="panel-footer">Spring도서관 - 이지후</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
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
				url :"book/all",
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
			// data에 있는 객체를 하나씩 꺼내서 담음 : obj
			$.each(data, function(index, obj){
				listHtml += "<tr>";
				listHtml += "<td>" + (index+1) + "</td>";
				listHtml += "<td id='t" + obj.num + "'>" 
				listHtml += obj.title;
				listHtml += "</td>";
				listHtml += "<td id='w" + obj.num + "'>" + obj.author + "</td>";
				listHtml += "<td>" + obj.company + "</td>";
				listHtml += "<td>" + obj.isbn + "</td>";
				listHtml += "<td>" + obj.count + "</td>";
				listHtml += "<td><button onclick='goDelete(" + obj.num + ")' class='btn btn-sm btn-warning'>삭제</button></td>";
				listHtml += "<td><button onclick='goUpdateForm(" + obj.num + ")' class='btn btn-sm btn-success'>수정</button></td>";
				listHtml += "</tr>";
		
			});
			
			$("#view").html(listHtml);

			goList();
		}
 		// goForm 함수를 만들어서 view는 감추고 wform은 보이게
		function goForm() {
			$('#bookList').css("display", "none");
			$('#wform').css("display", "table-row");
		}

		function goList() {
			$('#bookList').css("display", "table-row");
			$('#updateform').css("display", "none");
			$('#wform').css("display", "none");
		}

		function goInsert() {
			// 게시글 등록기능 : 비동기 방식
			// form 태그에 id값을 줘서 form태그 안에 있는 input 태그에 입력되는 값을 한번에 가져옴(직렬화)
			// ex) title="안녕"&content="반가워"&author="호두아빠"
			var fdata = $("#frm").serialize();
			$.ajax({
				// 통신에 성공하고 받아올 데이터가 없음 -> dataType 명시 X
				// -> 게시글을 다시 불러오는 기능 실행(loadList())
				// 요청할떄 보낼 데이터가 있음 -> data:보내줄 데이터
				url : "book/new",
				type : "post",
				data : fdata,
				success : loadList,
				error : function() {
					alert("error");
				}

			});

			$("#fclear").trigger("click");
		}
/*
		function goContent(num) {
			
				// display 속성값을 가져옴
				
				// 원래 : 누르면 기존에 있는 영역(안보이던)을 보이게 해줌
				// -> 누르면 새로 띄워주게(내용이 보이게) 만들기

				$.ajax({
					url : "book/" + num,
					// pathvariable방식 : 경로에다가 값을 붙여 보내는 방식
					type : "get",
					dataType : "json",
					success : function(data){
						// data = Board vo
						$("#ta" + num).val(data.content);
					},
					error : function(){
						alert("error");
					}
					
				});
				
				$("#c" + num).css("display", "table-row");



		} 
*/
		function goDelete(num) {
			$.ajax({
				url : "book/" + num,
				// url이름을 똑같이(상세보기 기능이랑) 만들어줌
				// but, 요청방식이 다름 : delete
				data : {"num" : num},
				type : "delete",
				success : loadList,
				error : function() {
					alert("error");
				}
			});
		}

		function goUpdateForm(num) {
			
			// 수정 버튼을 클릭하면 textarea(내용), 제목, 작성자 부분을 input태그로 바꿔주기
			$.ajax({
				url : "book/" + num,
				// pathvariable방식 : 경로에다가 값을 붙여 보내는 방식
				type : "get",
				dataType : "json",
				success : function(data){
				
					$("#nn").attr('value', data.num);
					$("#tt").attr('value', data.title);
					$("#aa").attr('value', data.author);
					$("#cc").attr('value', data.company);
					$("#ii").attr('value', data.isbn);
					//$("#hh").attr('value', data.count);
				
				},
				error : function(){
					alert("error");
				}
				
			});
			$('#bookList').css("display", "none");
			$('#updateform').css("display", "table-row");

		}

		function goUpdate() {
			var num = $("#nn").val();
			var count = $("#hh").val();

			$.ajax({
				url : "book/update",
				data : JSON.stringify({
					"num" : num,
					"count" : count
				}),
				type : "put",
				contentType : "application/json;charset=utf-8",
				success : loadList,
				error : function() {
					alert("error");
				}
			});
			$('#updateform').css("display", "none");
			$('#bookList').css("display", "table-row");
		}
	
		
	</script>
</body>
</html>