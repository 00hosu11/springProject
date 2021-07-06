<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<center>
<c:if test="${sessionScope.memId == null }">
<jsp:include page="/member/loginForm.jsp" />
</c:if>


<c:if test="${sessionScope.memId != null }">
<br><br>
<img src="/spring/image/purin01.jpg" width="100" height="100" 
	alt="푸린"  style="cursor:pointer;"><br>
	<jsp:include page="/member/loginOk.jsp" />
	<hr>
</c:if>

</center>