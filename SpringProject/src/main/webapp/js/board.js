//게시판 글쓰기
$('#boardWriteBtn').click(function(){
    $('#subjectDiv').empty();
	$('#contentDiv').empty();
	
	if($('#subject').val() == ''){
		$('#subjectDiv').html("제목 입력");
		$('#subjectDiv').css('color', 'red');
		$('#subjectDiv').css('font-size', '8pt');
		$('#subjectDiv').css('font-weight', 'bold');
	}else if($('#content').val() == ''){
		$('#contentDiv').html("내용 입력");
		$('#contentDiv').css('color', 'red');
		$('#contentDiv').css('font-size', '8pt');
		$('#contentDiv').css('font-weight', 'bold');
	}else{
		$.ajax({
			url: '/spring/board/boardWrite',
			type: 'post',
			data: {'subject': $('#subject').val(),
			       'content': $('#content').val()},
			success: function(){
				alert('글쓰기 완료');                      //스프링에서건 페이지가 기본이1페이지랑 굳이 끝에안줘도된다
				location.href='/spring/board/boardList';
			},
			error: function(err){
				console.log(err);
			}
		});
	}
});

// 게시판 목록 불러오기
$(document).ready(function() {
	$.ajax({
		type : 'post',
		url : '/spring/board/getBoardList',
		dataType : 'json',
		success : function(data) {

			var table;
			$.each(data.list, function(index, items) {
				$('<tr/>').append($('<td/>', {
					align : 'center',
					text : items.seq
				})).append($('<td/>', {
					align : 'center',
					text : items.subject
				})).append($('<td/>', {
					align : 'center',
					text : items.content
				})).append($('<td/>', {
					align : 'center',
					text : items.logtime
				})).append($('<td/>', {
					align : 'center',
					text : items.seq
				})).appendTo($('#table'));

			});// each
			$('#table').append(table);
		},
		error : function(err) {
			console.log(err);
		}
	});
});



//답글쓰기
$('#boardReplyBtn').click(function(){
	$('#subjectDiv').empty();
	$('#contentDiv').empty();
	
	if($('#subject').val() == ''){
		$('#subjectDiv').html("제목 입력");
		$('#subjectDiv').css('color', 'red');
		$('#subjectDiv').css('font-size', '8pt');
		$('#subjectDiv').css('font-weight', 'bold');
	}else if($('#content').val() == ''){
		$('#contentDiv').html("내용 입력");
		$('#contentDiv').css('color', 'red');
		$('#contentDiv').css('font-size', '8pt');
		$('#contentDiv').css('font-weight', 'bold');
	}else{
		$.ajax({
			url: '/spring/board/boardReply',
			type: 'post',
			data: {
				   'pseq' :$('input[name=pseq]').val(), //원글번호
				   'subject': $('#subject').val(),
			       'content': $('#content').val()},
			success: function(){
				alert('답글쓰기 완료');
				location.href='/spring/board/boardList?pg='+$('input[name=pg]').val();
			},
			error: function(err){
				console.log(err);
			}
		});
	}
});
