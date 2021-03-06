<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
td {
	font-size: 8pt;
}

#addressA:link {color: black; text-decoration: none;}
#addressA:visited {color: black; text-decoration: none;}
#addressA:hover {color: green; text-decoration: underline; font-weight: bold;}
#addressA:active {color: black; text-decoration: none;}
</style>
</head>
<body>
<form id="checkPostForm">
<table border="1" cellpadding="5" cellspacing="0" id="checkPostTable">
	<tr>
		<td align="center" width="100">시도</td>
		<td>
			<select name="sido">
			<option value="">시도선택</option>
			<option value="서울">서울</option>
            <option value="인천">인천</option>
            <option value="대전">대전</option>
            <option value="대구">대구</option>
            <option value="울산">울산</option>
            <option value="세종">세종</option>
            <option value="광주">광주</option>
            <option value="경기">경기</option>
            <option value="강원">강원</option>
            <option value="전남">전남</option>
            <option value="경남">경남</option>
            <option value="경북">경북</option>
            <option value="충남">충남</option>
            <option value="충북">충북</option>
            <option value="부산">부산</option>
            <option value="제주">제주</option>
			</select>
		</td>
		<td width="100" align="center">시.군.구</td>
		<td>
			<input type="text" name="sigungu" size="10">
		</td>
	</tr>
	
	<tr>
		<td align="center">도로명</td>
		<td colspan="3">
			<input type="text" name="roadname">
 			<input type="button" id="checkPostSearchBtn" value="검색">
 		</td>
	</tr>
	
	<tr>
		<td align="center" style="font-size: 8pt;">우편번호</td>
		<td colspan="3" align="center" style="font-size: 8pt;">주소</td>
	</tr>
	
	<c:if test="${requestScope.list != null }" >
	
		<c:forEach var="zipcodeDTO" items="${list}">
		
			<c:set var="address">
				${zipcodeDTO.sido 
				} ${zipcodeDTO.sigungu 
				} ${zipcodeDTO.yubmyundong 
				} ${zipcodeDTO.ri 
				} ${zipcodeDTO.roadname 
				} ${zipcodeDTO.buildingname }
			</c:set>

			<tr>
				<td align="center">${zipcodeDTO.zipcode }</td>
				<td colspan="3">
					<a href="#" id="addressA" onclick="checkPostClose('${zipcodeDTO.zipcode }', '${address }')">${address }</a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
</table>
</form>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/member.js"></script>

</body>
</html>

