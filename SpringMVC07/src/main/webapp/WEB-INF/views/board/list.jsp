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
		<h2>SpringMVC07</h2>
		<div class="panel panel-default">
			<div class="panel-heading">
			<c:if test="${not empty m}">
				<form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
					<div class="form-group
					">
						<label>${m.memName}님 환영합니다!</label>
					</div>
					<button type="submit" class="btn btn-xs btn-default pull-right">로그아웃</button>
					
				</form>
			</c:if>
			
			<c:if test="${empty m}">
				<form action="${cpath}/login/loginProcess" method="post">
					<div class="form-group">
						<label for="id">ID:</label>
						<input type="text" class="form-control" id="id" name="memId">
					</div>
					<div class="form-group">
						<label for="pw">Password:</label>
						<input type="password" class="form-control" id="pw" name="memPw">
					</div>
					<button class="btn btn-sm btn-success" type="submit">로그인</button>
				</form>
			</c:if>
			
			</div>
			<div class="panel-body">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
					<!-- 테이블 안에 영역 구분하기 위해 쓰는 태그 : tbody -->
                             
                   <!-- 게시글 출력 -->
                   <c:forEach items="${list}" var="vo" varStatus="i">
                                           <!-- 반복횟수를 기억하고 있는 변수 -->
                      <tr>
                         <td>${i.count}</td>
                         
                         <td> <!-- 게시글 제목 -->
                         <c:if test="${vo.boardAvailable == 0 }">
                            <!-- 삭제여부 확인 - 게시글/답글 삭제 시 접근불가 alert으로 알려주기  -->
                            <a href="javascript:alert('삭제된 게시글입니다')">
                               <!-- href 이동 불가하도록 클릭 시 alert 띄움 -->
                            <c:if test="${vo.boardLevel > 0}">
                                         <!-- 댓글 달 경우 -->
                               <c:forEach begin="0" end="${vo.boardLevel}" step="1">
                                  <!-- 댓글: 반복 2번, 대댓글: 3번 -->
                                  <span style="padding-left:8px;"></span>
                               </c:forEach>
                                └ [Re]
                            </c:if>                                                     
                            삭제된 게시물입니다. <!-- 글 제목 변경 -->
                            </a>                         
                         </c:if>
                         
                         <!-- 삭제x -->
                               <c:if test="${vo.boardAvailable > 0}">
                                  <a href="${cpath}/board/get?idx=${vo.idx}">
                                  <c:if test="${vo.boardLevel > 0}">
                                                 <!-- 댓글 달 경우 -->   
                                     <c:forEach begin="0" end="${vo.boardLevel}" step="1">
                                  <!-- 댓글: 반복 2번, 대댓글: 3번 -->
                                        <span style="padding-left: 15px"></span>
                                     </c:forEach>
                                     ㄴ[RE]
                                  </c:if>
                         
                                  <c:out value="${vo.title }"/>
                                  </a>
                               </c:if>                         
                         </td>
                         <!-- XSS(Cross Site Scripting) : 웹 사이트에 스크립트 코드를 주입하여 공격하는 기술
                               ==> 이를 방지하기 위해서 el식을 바로 쓰지 않음  
                               c:out - 문자 그대로 인식해서 출력 -->
                         <td>${vo.writer}</td>
                         <td>
                            <fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/>
                         </td>
                         <td>${vo.count}</td>
                      </tr>
                   </c:forEach>
                </tbody>
					<c:if test="${not empty m}">
					<tr>
						<td colspan="5">
							<button id="regbtn" class="btn btn-xs btn-info pull-right">글쓰기</button>
						</td>
					</tr>
					</c:if>
				</table>
			
			</div>
			<div class="panel-footer">끝</div>
		</div>
	</div>
	
	 <!-- Modal -->
     <div class="modal fade" id="myMsg" role="dialog">
       <div class="modal-dialog modal-sm">      
         <div class="modal-content" id="messageType">
           <div class="modal-header panel-heading">
             <button type="button" class="close" data-dismiss="modal">&times;</button>
             <h4 class="modal-title">알림창</h4>
           </div>
           <div class="modal-body">
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
           </div>
         </div>      
       </div>
     </div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var result = "${result}";
			checkModal(result);
			$("#regbtn").click(function(){
				location.href="${cpath}/board/register";
			});
			
		});
		
		function checkModal(result){
			if(result == ''){
				return;
			}
			if(parseInt(result) > 0){
				$(".modal-body").text("게시글" + result + "번이 등록되었습니다.");
				$("#myMsg").modal("show");
			}
		}
	
	</script>
</body>
</html>