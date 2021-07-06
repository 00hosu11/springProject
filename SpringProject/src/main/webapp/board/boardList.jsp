<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#subjectH:link {color: black; text-decoration: none;}
#subjectH:visited {color: green; text-decoration: none;}
#subjectH:hover {color: magenta; text-decoration: underline;}
#subjectH:active {color :green; text-decoration: none;}


#currentPaging{
	font-size: 2em; 
	color:red; 
	text-decoration: underline;
	cursor:pointer; 

}
#paging{
	font-size: 2em; 
	color:black; 
	text-decoration: none;
	cursor:pointer; 
}

</style>
</head>
<body>
      								<!-- 컨트롤러에서 들어오는 pg값 -->
      <input type="hidden" id="pg" value="${pg }" > <%--BoardController로 부터 오는 pg를 받았다 --%>
      
      <h1 align="center">글목록</h1>
		
      <table id="boardListTable" border="1" bordercolor="indigo" width="700" height="30"
         align="center" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">
   
         <tr>
	         <th bgcolor="skyblue" align="center" width="80">글번호</th>
	         <th bgcolor="skyblue" align="center" width="300">제목</th>
	         <th bgcolor="skyblue" align="center" width="150">작성자</th>
	         <th bgcolor="skyblue" align="center" width="150">작성일</th>
	         <th bgcolor="skyblue" align="center" width="80">조회수</th>
         </tr>

      </table>
      <br>
 
	<div id="boardPagingDiv" align="center"></div>

	<br>
	<br>

<!-- 검색 -->
<form id="boardSearchForm">
	<input type="hidden" name="pg" value="1"> <!-- 검색한 내용을 1페이지로 부터 보여주기 위해서 BoardController로 보내는거 -->
	
	<div class="boardSearch" align="center">
		<select name="searchOption" id="searchOption">
			<option value="subject" >제목</option>
			<option value="id" >작성자</option>
		</select>
			<input type="search" name="keyword" id="keyword" value="${keyword }"/>
			<input type="button" value="검색" id="boardSearchBtn" >
	</div>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/boardList.js"></script>


<script type="text/javascript">

function boardPaging(pg){
   var keyword = document.getElementById('keyword').value;
   if(keyword==''){
      location.href = 'boardList?pg='+pg;
   }else{
	   //페이지를 누르면 research값이 가고 그냥 검색해서 검색버튼누르면 research값이 안가서 무조건 1페이지로 간다
	   
	   //1번인 경우
	   $('input[name=pg]').val(pg); //form 안에 pg의 값이 1로 고정되어 있기 때문
   	   //$('#boardSearchBtn').trigger('click' , 'research');//강제 이벤트를 발생         
   	   $('#boardSearchBtn').trigger('click');//강제 이벤트를 발생         
   	   //만약 [2]페이지 에서 다시 검색 버튼을 누르면 1페이지부터 뜨는게 아니라 [2]페이지부터 검색이 시작된다.
   	   
   	   //검색 버튼을 눌렀을 때 1페이지 부터 다시 검색할수 있도록 pg를 바꿔주어야 한다.
   	   $('input[name=pg').val(1);
   	   
   	   //2번인 경우
   	/*   $('input[name=pg]').val(pg); //form 안에 pg의 값이 1로 고정되어 있기 때문
  	   $('#boardSearchBtn').trigger('click' , 'research');//강제 이벤트를 발생         
  	   //만약 [2]페이지 에서 다시 검색 버튼을 누르면 1페이지부터 뜨는게 아니라 [2]페이지부터 검색이 시작된다.
  	   //검색 버튼을 눌렀을 때 1페이지 부터 다시 검색할수 있도록 pg를 바꿔주어야 한다.
	   //boardList.js에서 주석건거 풀어줘야한다. */
   }
}



</script>

</body>
</html>