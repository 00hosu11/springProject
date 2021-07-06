<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<title>글 목록 작성글</title>
<style type="text/css">

.content{
white-space: normal;
}

pre{
	word-wrap :word-break;
	white-space: pre-wrap;
	word-break: break-all;
}

</style>
</head>
<body>
<h3 align="center">작성글</h3>
<form name="boardViewForm">
<input type="hidden" name="seq" id="seq" value="${seq }">
<input type="hidden" name="pg" id="pg" value="${pg }">
<input type="hidden" name="hit" id="hit" id= value="${hit }">

  <table border="1" bordercolor="indigo" width="700" height="30"
         align="center" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">

   
         <tr>
            <td align="center" width="100" colspan="3"><span id="subjectSpan"></span></td>
         </tr>
         
         <tr>
            <td align="center">글번호 :<span id="seqSpan"></span></td>
            <td align="center">작성자 :<span id="idSpan"></span></td>
            <td align="center">조회수 :<span id="hitSpan"></span></td>
         </tr>
         
          <tr>
            <td id="content" align="center" width="100" colspan="3" height="300" valign="top" style="text-align:left;" >
			<div  style="overflow-y: auto; width:100%; height:100%;">
				<pre><span id="contentSpan"></span></pre>
			</div>
            </td>
         </tr>

         
      </table>

      <br>
      <div align="center">
      <input type="button"  value="목록" onclick="location.href='boardList?pg=${pg }'">
      
      <span id="boardViewSpan">
      <input type="button"  value="글수정" onclick="mode(1)">
      <input type="button"  value="글삭제" onclick="mode(2)">
 	  </span>
      <input type="button"  value="답글" onclick="mode(3)">
      </div>
      
</form>      

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
	$.ajax({
		url: '/spring/board/getBoard',
		type: 'post',
		data: 'seq='+$('#seq').val(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			//console.log(JSON.stringify(data));
			
			$('#subjectSpan').text(data.boardDTO.subject);
			$('#seqSpan').text(data.boardDTO.seq);
			$('#idSpan').text(data.boardDTO.id);
			$('#hitSpan').text(data.boardDTO.hit);
			$('#contentSpan').text(data.boardDTO.content);
			
			
			if(data.memId == data.boardDTO.id){
				$('#boardViewSpan').show();
			}else{
				$('#boardViewSpan').hide();
			}
		},
		error: function(err){
			console.log(err);
		}
	});
});
</script>


<script type="text/javascript">
function mode(num){
	if(num==1){//글수정
		document.boardViewForm.method="post";
		document.boardViewForm.action="boardModifyForm"
		document.boardViewForm.submit();
		
	}else if(num==2){//글삭제
		if(confirm("정말로 삭제하시겠습니까?")){
			document.boardViewForm.method="post";
			document.boardViewForm.action="boardDelete"
			document.boardViewForm.submit();
			}

	}else if(num==3){//답글
		document.boardViewForm.method="post";
		document.boardViewForm.action="boardReplyForm"
		document.boardViewForm.submit();
	}
	
}
</script>
