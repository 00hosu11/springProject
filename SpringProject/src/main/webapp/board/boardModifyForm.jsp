<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<form name="boardModifyForm" id="boardModifyForm">

<input type="hidden" name="seq" id="seq" value="${seq }">
<input type="hidden" name="pg" id="pg" value="${pg }">

      <h1 align="center">글수정</h1>

      <table border="1" bordercolor="indigo" width="300" height="100"
         align="center" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">

         <!--제목-->
        <tr>
            <td align="center" width="120">제목</td>
            <td><input id="subject" name="subject" type="text" size=50 style="background:transparent;" >
            <div id="subjectDiv"></div>
            </td>
         </tr>

        <!--내용-->
        <tr>
            <td  align="center" width="120">내용</td>
            <td><textarea id="content" name="content"  style="width:380px; font-family:함초롬돋움; height:180px; border:0; background: transparent; 
            font-size:13pt;  outline:none; resize:none;"></textarea>
            <div id="contentDiv"></div>
            </td>
         </tr>

         <!--버튼 -->
         <tr>
            <td colspan="2" width="200" align="center">
            <input type="button" value="글수정" id="boardModifyBtn">
            <input type="reset" value="다시작성" >
            </td>
         </tr>


      </table>
   </form>
   
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$.ajax({
		type: 'post',    /* 한사람의 글을 잡아오는거  */
		url: '/spring/board/getBoard',
		data: 'seq='+$('input[name=seq]').val(),
		dataType: 'json',
		success: function(data){
			$('#subject').val(data.boardDTO.subject); //id가 subject인 인풋에 값을 넣어주자~		
			$('#content').val(data.boardDTO.content);		
		},
		error: function(err){
			console.log(err);
		}
	});
});
</script>

<script type="text/javascript">
$('#boardModifyBtn').click(function(){
	$('#subjectDiv').empty();
	$('#contentDiv').empty();
	
	if($('#subject').val() == ''){
		$('#subjectDiv').text("제목 입력");
		$('#subjectDiv').css('color', 'red');
		$('#subjectDiv').css('font-size', '8pt');
		$('#subjectDiv').css('font-weight', 'bold');
	}else if($('#content').val() == ''){
		$('#contentDiv').text("내용 입력");
		$('#contentDiv').css('color', 'red');
		$('#contentDiv').css('font-size', '8pt');
		$('#contentDiv').css('font-weight', 'bold');
	}else{
		$.ajax({
			type:'post',
			url: '/spring/board/boardModify',
			data: 
			/* {
				   'seq': $('#seq').val(),
	               'subject': $('#subject').val(),
	               'content': $('#content').val()
	        }, */
	        
	        $('#boardModifyForm').serialize(),
	        success: function(){
				alert('게시판 수정 완료')
				location.href='/spring/board/boardList';
			},
		    error:function(err){
		        console.log(err);
		        alert('게시판 수정 실패');
			}
			
	      });
	}
});
</script>


</body>
</html>