<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	margin:0;
	padding: 0;
	height: 100%;
	width: auto;
}

#header{
	width: 100%;
	height: 100%;
	text-align: center;
/* 	border: 1px solid lightgray; */
}

#container {
	width: 100%;
	height: 600px;
	/* border: 1px solid lightgray; */
}

#container:after{
	content: '';
	display: block;
	clear: both;
	float: none;
}

#nav{
	margin-left: 30px;
	width: 15%;
	height: 100%;
	float: left;
/* 	border: 1px solid red; */
}

#section{
	width: 79%;
	height: 100%;
	float: left;
/* 	border: 1px solid blue; */
}

#footer{
	width: 100%;
	height: 10%;
/* 	border: 1px solid lightgray; */
}

</style>
</head>
<body>
<div id="header" style="background-color: black">
	<h1 style="color: white; margin:0;">
	<img src="/spring/image/purin.png" width="70" height="70" 
	alt="푸린"  onclick = "location.href='/spring/index.jsp'" style="cursor:pointer;">
	 MVC 기반의 미니 프로젝트
	</h1>
		<jsp:include page="/main/menu.jsp" />
</div>

<div id="container">
	<div id="nav">
		<jsp:include page="/main/nav.jsp" />
	</div>
	
	<div id="section">
      <c:if test="${empty display }">
      <center>
      	 <img src="/spring/image/purin00.jpg" width="500" height="500" alt="푸린00">
         <h2>홈페이지를 방문해주셔서 감사합니다~^^<br>행복한 하루 되세요~^^</h2>
      </center>
      </c:if>
      <c:if test="${not empty display }">
         <jsp:include page="${display }" />
      </c:if>
   </div> <!-- jsp의 모든 소스를 가지고 와라! -->
</div>

<div id="footer">
	<p>비트캠프<p>
</div>
</body>
</html>