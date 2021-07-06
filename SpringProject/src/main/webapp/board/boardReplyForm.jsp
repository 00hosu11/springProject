<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
div#subjectDiv , div#contentDiv {
	color: white;
	font-size: 8pt;
	font-weight: bold;
}

</style>

 <form id='boardReplyForm' >
	 <input type="hidden" name="pseq" value="${pseq }">
	 <input type="hidden" name="pg" value="${pg }">
	 
      <h1 align="center">답글 쓰기</h1>

      <table border="1" bordercolor="indigo" width="500" height="200"
         align="center" cellspacing="0" cellpadding="3">

        

         <!--제목-->
        <tr>
            <td bgcolor="skyblue" align="center" width="100">제목</td>
            <td><input id="subject" name="subject" type="text" size=50">
            <div id="subjectDiv"></div>
            </td>
         </tr>

        <!--내용-->
        <tr>
            <td bgcolor="skyblue" align="center" width="100">내용</td>
            <td><textarea id="content" name="content" style="width:380px; font-family:함초롬돋움; height:180px; font-size:13pt;"></textarea>
            <div id="contentDiv"></div>
            </td>
         </tr>

       

         <!--버튼 -->
         <tr>
            <td colspan="2" width="200" align="center">
            <input type="button" value="답글 쓰기" id="boardReplyBtn" style="font-size:11pt;">
           <input type="reset" value="다시작성" style="font-size:11pt;">
            </td>                          
         </tr>


      </table>
   </form>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/board.js"></script>
