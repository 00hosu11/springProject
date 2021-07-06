<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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

 <form name="imageboardViewForm" method="post" enctype="muLtipart/form-data" action="imageboardList.do">
      <h1 align="center">이미지 뷰</h1>
      <input type="hidden" id="pg" name="pg" value="${pg }">
      <input type="hidden" id="seq" name="seq" value="${seq }">

      <table border="1" bordercolor="indigo"
         align="center" cellspacing="0" cellpadding="10" frame="hsides" rules="rows" style="margin-bottom:3px;">

  		
		<!-- 이미지 -->
  		<tr>
            <td rowspan="5">
           		 <img id="image1" width="200px" height="200px">
            </td>
        </tr>
        <tr>
            <td>상품명: <span id="imageNameSpan"></span></td>
        </tr>
          <tr>
            <td>단가 : <span id="imagePriceSpan"></span></td>
        </tr>
          <tr>
            <td>개수 : <span id="imageQtySpan"></span></td>
        </tr>
        <tr>
            <td>합계 : <span id="totalSpan"></span></td>
        </tr>
        
        
		<tr>
		 <td colspan="2" id="content">
		 	<pre><span id="imageContentSpan"></span></pre>
		 </td>
		</tr>
	
		
      </table>
      <!-- 버튼 -->
      <br>
      <div align="center">
  	   <input type="button" value="목록" onclick="location.href='imageboardList?pg=${pg }'"/>
  	 </div>
   </form>
   
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$.ajax({
		type : 'post',
		url : '/spring/imageboard/imageboardView',
		data: 'seq=${seq}',
		dataType : 'json',
        success:function(data) {
            console.log(data);
            var total=data.imageboardDTO.imageQty*data.imageboardDTO.imagePrice;
            $('#image1').attr('src','../storage/'+data.imageboardDTO.image1);
            $('#imageNameSpan').text(data.imageboardDTO.imageName)
            $('#imageQtySpan').text(data.imageboardDTO.imageQty)
            $('#imagePriceSpan').text(data.imageboardDTO.imagePrice.toLocaleString())
            $('#imageContentSpan').text(data.imageboardDTO.imageContent)
            $('#totalSpan').text(total.toLocaleString())
         },
		error: function(err){
			console.log(err);
		}
	});
});
</script>

