<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
#currentPaging{
	font-size: 2em; color:red; text-decoration: underline;
	cursor: pointer;
	margin: 5px;
}
#paging{
	font-size: 2em; color:black; text-decoration: none;
	cursor: pointer;
	margin: 5px;
}
</style>


	<form id="imageboardDeleteForm" method="get" action="imageboardDelete">
		<input type="hidden" id="pg" name="pg" value="${pg }">
		<h1 align="center">글목록</h1>

		<table id="imageboardListTable" border="1" bordercolor="indigo" width="700" height="30"
			align="center" cellspacing="0" cellpadding="5" frame="hsides"
			rules="rows">

			<tr>
				<th bgcolor="skyblue" align="center" width="80">
				<input type="checkbox" id="all" >번호</th>
				<th bgcolor="skyblue" align="center" width="300">이미지</th>
				<th bgcolor="skyblue" align="center" width="150">상품명</th>
				<th bgcolor="skyblue" align="center" width="150">단가</th>
				<th bgcolor="skyblue" align="center" width="80">개수</th>
				<th bgcolor="skyblue" align="center" width="80">합계</th>
			</tr>
		</table>
		
			<br>
			
			<div id="imagboardPagingDiv" align="center"></div>
			<br><br>
		<div align="center" >
		<input type="button" value="선택 삭제" id="choiceDeletBtn" >
		</div>
	</form>
	
	
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$.ajax({
		type : 'post',
		url : '/spring/imageboard/getImageboardList',
		data: 'pg=${pg}', //컨트롤러로부터 넘어온 값,   
		//data: 'pg='+$('#pg').val()  // hidden 태그 잡아서 값을 쓸때는 이렇게 써준다.
		dataType : 'json',
		success : function(data) {
			console.log(data);
			
			   $.each(data.list,function(index,items){
		            $('<tr/>').append($('<td/>',{
		               align:'center',
		               text:items.seq
			            }).prepend($('<input/>',{
			            	type:'checkbox',
			            	name: 'check',
			            	value: items.seq
			            }))
		            ).append($('<td/>',{
		       	      align:'center',
		               }).append($('<img/>',{
		                  src:'/spring/storage/'+items.image1,
		                  style:'width:70px; height:70px; cursor:pointer;',
		                  class:"img_"+items.seq
		               }))
		            ).append($('<td/>',{
		               align:'center',
		               text:items.imageName
		            })).append($('<td/>',{
		               align:'center',
		               text:items.imagePrice.toLocaleString()
		            })).append($('<td/>',{
		               align:'center',
		               text:items.imageQty
		            })).append($('<td/>',{
		               align:'center',
		               text:(items.imagePrice*items.imageQty).toLocaleString()
		            })).appendTo($('#imageboardListTable'));

		            $('.img_'+items.seq).click(function(){//seq, pg 
		               
		               location.href='/spring/imageboard/imageboardView?seq='+items.seq+'&pg='+$('#pg').val();
		            });
		         });//each

		         
		         //페이징처리
		         $('#imagboardPagingDiv').html(data.imageboardPaging.pagingHTML);
		         
		         
		},
		error : function(err) {
			console.log(err);
		}
	});
});

</script>


<script type="text/javascript">
function imageboardPaging(pg){
	location.href="imageboardList?pg="+pg;
}

//전체 선택 또는 해제
$('#all').click(function(){
	//alert($('#all').attr('checked')); //checked 속성이 없어서 undefind 으로 나온다.
	//alert($('#all').prop('checked')); //true 또는 false
	
	if($('#all').prop('checked')){
		$('input[name=check]').prop('checked' , true);
	}else{
		$('input[name=check]').prop('checked' , false);
	}
	
});


//선택 삭제
$('#choiceDeletBtn').click(function(){
	var count = $('input[name=check]:checked').length;
	
	if(count == 0){
		alert("삭제 할 항목을 선택하세요");
	}else {
		if(confirm("정말로 삭제 ??"))
			$('#imageboardDeleteForm').submit();
	}
});
</script>


