<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
.mainnav{
	padding-left: 50px;
	background-color: #005B9B;
	list-style: none;
}

.mainnav:after{ /*container-snb,content  바로 붙지 않게 하기 위해서 clear 함 */
	content: '';
	display: block;
	clear: both;
}

.mainnav li{
	float: left;
	padding-left: 300px;
}

.mainnav li a {
	display: block;
	padding: 0 13px; /*  위아래, 좌우 */
	background-color: #005B9B;
	color: #ffffff;
	font: bold 16px/40px 'Nanum Gothic', sans-serif; 
		/*폰트의 굵기 | 글자의 크기 | /line-height 줄간격 |  글꼴  , 앞에 글꼴없으면 다음 글꼴*/
	text-transform: uppercase;
	text-decoration: none;
}
.mainnav li a:hover {
	color: #660000;
	background-color: #ffcc00;
}
</style>

<ul class="mainnav">
			<c:if test="${sessionScope.memId != null }">
			<li><a href="/miniProject/board/boardWriteForm">글쓰기</a><li>
			<li><a href="#">이미지파일 올리기</a><li>
			</c:if>
			<li><a href="/miniProject/board/boardList?pg=1">목록</a><li>
			<li><a href="#">이미지 게시판</a><li>
			
		</ul>


