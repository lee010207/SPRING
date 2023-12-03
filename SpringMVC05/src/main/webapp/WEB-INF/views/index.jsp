<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!-- jstl 가져오기 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 여러 기능이 있는 함수 가져오기 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
 
<!-- Context-Path 절대경로 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    

<!DOCTYPE html>
<html lang="en">
<head>
  <title>메인</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

  
    <!-- 따로 저장해둔 메뉴바 불러오기 -->
   <jsp:include page="common/header.jsp"></jsp:include>
   
<div class="container">
     <h3>Spring MVC05</h3>
     <div class="panel panel-default">
        <div>
           <!-- 이미지 경로 설정 - dispacther servlet (web.xml)-->
           <img src="${contextPath}/resources/images/main.jpg" style="width: 100%; height:500px;">
        </div>
        <div class="panel-body">
          <ul class="nav nav-tabs">
             <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
             <li><a data-toggle="tab" href="#menu1">게시판</a></li>
             <li><a data-toggle="tab" href="#menu2">공지사항</a></li>
             <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
           </ul>
         
           <div class="tab-content">
             <div id="home" class="tab-pane fade in active">
               <h3>HOME</h3>
               <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
             </div>
             <div id="menu1" class="tab-pane fade">
               <h3>게시판</h3>
               <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
             </div>
             <div id="menu2" class="tab-pane fade">
               <h3>공지사항</h3>
               <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
             </div>
             <div id="menu3" class="tab-pane fade">
               <h3>Menu 3</h3>
               <p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
             </div>
           </div>     
        </div>
        <div class="panel-footer">
           Spring-${mvo.memName}
        </div>
     </div>

</div>





     <!-- Modal ()-->
     <div class="modal fade" id="myMessage" role="dialog">
       <div class="modal-dialog modal-sm">      
         <div class="modal-content" id="messageType">
           <div class="modal-header panel-heading">
             <button type="button" class="close" data-dismiss="modal">&times;</button>
             <h4 class="modal-title">${msgType}</h4>
           </div>
           <div class="modal-body">
             <p id="">${msg}</p>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
           </div>
         </div>      
       </div>
     </div>

   <script type="text/javascript">
      $(document).ready(function(){
         if(${not empty msgType}){
            // msgType이 비어있지 않을 경우 (회원가입 실패) - el식
            if(${msgType eq "성공 메세지"}) {
               // msgType이 "실패 메세지"일 경우
               $("#messageType").attr("class", "modal-content panel-success");
            }
            $("#myMessage").modal("show");
         }         
         
         
      });
   
   
   </script>



</body>
</html>