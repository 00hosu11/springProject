// $(function(){});
// $(document.ready(function(){})); 둘 다 onload!

//목록
$(function(){
   $.ajax({
      url: '/spring/board/getBoardList',
      type: 'post',
      data: 'pg='+$('#pg').val(),
      dataType: 'json',
      success: function(data){
    	  //alert(JSON.stringify(data)); // json 형식으로 출력해주세요~
          console.log(data);
    	  
      	 $.each(data.list, function(index,items){
            $('<tr/>').append($('<td/>',{
               align: 'center',
               text: items.seq
            })).append($('<td/>',{
            	
           	   }).append($('<a/>',{
					href: '#',
	                text: items.subject,
					id: 'subjectH',
					class: 'subject_'+items.seq
				}))
			).append($('<td/>',{
               align: 'center',
               text: items.id
            })).append($('<td/>',{
               align: 'center',
               text: items.logtime
            })).append($('<td/>',{
               align: 'center',
               text: items.hit
            })).appendTo($('#boardListTable'));
            
            
            //답글
            for(var i=1; i<=items.lev; i++){
                $('.subject_'+items.seq).before('&emsp;');
            }
            if(items.pseq != 0){  //내(중심으로)앞에가 before   / prev는 내 형제의 앞에
        		$('.subject_'+items.seq).before($('<img/>',{
        			src: '../image/reply.gif'
        		}));
            }//if
            
             //로그인 여부 -1번
//			$('.subject_'+items.seq).click(function(){
//				if(data.memId == null) {
//					alert('먼저 로그인 하세요');
//				}else {
//					//alert(data.memId)
//					location.href = '/spring/board/boardView?seq='+items.seq+'&pg='+$('#pg').val();
//				}
//				
//			});
			
            
		 });//each
	
		
		//로그인 여부 - 2번 이벤트를 on을 써서 움직여야 한다.
      	//앞에 부모(조상님이)가 와야한다           id가 subjectH인 애가 클릭당할때 벌어지는 일이다 라는 뜻
      	 //$(document).on('click', '#subjectH', function(){
      	 $('#boardListTable').on('click', '#subjectH', function(){
			//alert($(this).prop('tagName'));
			//alert($(this).parent().prev().text());
			
			if(data.memId == null){
				alert("먼저 로그인 하세요");
			}else{          //a태그의 부모의 앞의 값
				var seq = $(this).parent().prev().text();
				location.href = '/spring/board/boardView?seq='+seq+'&pg='+$('#pg').val();
		}
		});
		
		//페이징 처리                                                         //getPagingHTML()하고 같은거
		$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
		
      },
      error: function(err){
         console.log(err);
      }
   });
});






//검색
//1번인 경우
$('#boardSearchBtn').click(function() {

//2번인 경우일때 주석풀어서써주기
//처음부터 다시검색
//$('#boardSearchBtn').click(function(event, str) {
//if(str != 'research') $('input[name=pg').val(1); //직접 검색 버튼을 클릭했을 때

	if ($('#keyword').val() == '') {
		alert('검색어 먼저 입력하세요.');
	}else {
		$.ajax({
			type : 'post',
			url : '/spring/board/boardSearch',
			data: $('#boardSearchForm').serialize(),
			dataType : 'json',
			success : function(data) {
				//alert(JSON.stringify(data));

				if (JSON.stringify(data) == '{"list":[]}') {
					alert('없지롱~')
				} else {
					$('#boardListTable tr:gt(0)').remove();
					
					 $.each(data.list, function(index,items){
				            $('<tr/>').append($('<td/>',{
				               align: 'center',
				               text: items.seq
				            })).append($('<td/>',{
				            	
				           	   }).append($('<a/>',{
									href: '#',
					                text: items.subject,
									id: 'subjectH',
									class: 'subject_'+items.seq
								}))
							).append($('<td/>',{
				               align: 'center',
				               text: items.id
				            })).append($('<td/>',{
				               align: 'center',
				               text: items.logtime
				            })).append($('<td/>',{
				               align: 'center',
				               text: items.hit
				            })).appendTo($('#boardListTable'));

				            
				          //로그인 여부 -1번
							$('.subject_'+items.seq).click(function(){
								if(data.memId == null) {
									alert('먼저 로그인 하세요');
								}else {
									//alert(data.memId)
									location.href = '/spring/board/boardView?seq='+items.seq+'&pg='+$('#pg').val();
								}
							});
				            
					});// each
				}//else
				
				//페이징 처리                                                         //getPagingHTML()하고 같은거
				$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
				
			},
			error : function(err) {
				alert("실패")
				console.log(err);
			}
		});
	}
});

