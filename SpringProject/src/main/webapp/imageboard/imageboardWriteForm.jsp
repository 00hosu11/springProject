<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>이미지 게시판</title>

<style type="text/css">
div#imageIdDiv , div#imageNameDiv , div#imagePriceDiv , div#imageQtyDiv , div#imageContentDiv {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>
	<%--1번  단순 submit ~ action 방식 --%>
    <%-- <form id="imageboardWriteForm" method="post" enctype="muLtipart/form-data" action="imageboardWrite"> --%>
   
   <%--2번  AJax 방식 --%>
   <form id="imageboardWriteForm">
   
      <h1 align="center">이미지 게시판</h1>

      <table border="1" bordercolor="indigo" width="500" height="300"
         align="center" cellspacing="0" cellpadding="10">

         <!--상품 코드 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="200">상품코드</td>
            <td><input name="imageId" type="text" value="img_" size="50">
            <div id="imageIdDiv"></div>
            </td>
         </tr>

         <!-- 상품명 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100">상품명</td>
            <td><input id="imageName" name="imageName" type="text"  placeholder="상품명 입력" size="50">
            <div id="imageNameDiv"></div>
            </td>
         </tr>
         
          <!-- 단가 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100">단가</td>
            <td><input id="imagePrice"  name="imagePrice" type="text"  placeholder="단가 입력" size="50">
            <div id="imagePriceDiv"></div>
            </td>
         </tr>
	
		  <!-- 개수 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100">개수</td>
            <td><input id="imageQty" name="imageQty" type="text"  placeholder="개수 입력" size="50">
            <div id="imageQtyDiv"></div>
            </td>
         </tr>

   		 <!-- 내용 -->
        <tr>
            <td bgcolor="skyblue" align="center" width="100">내용</td>
            <td><textarea  id="imageContent" name="imageContent" 
            style="width:380px; font-family:함초롬돋움; height:180px; resize:none;"></textarea>
            <div id="imageContentDiv"></div>
            </td>
         </tr>
         
		<!-- 파일 -->	
		<tr>
			<td colspan="2">
				<input type="file" name="img" size="50">
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="file" name="img" size="50">
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="file" name="img[]" multiple size="50">
			</td>
		</tr>
		
         <!-- 버튼 -->
         <tr>
            <td colspan="2" width="200" align="center">
            <input type="button" value="이미지등록" id="imageboardWriteBtn">
            <input type="reset" value="다시작성">
            </td>
         </tr>


      </table>
   </form>
   
   <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script src="../js/imageboard.js"></script>
  