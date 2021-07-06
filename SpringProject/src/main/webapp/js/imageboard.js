$('#imageboardWriteBtn').click(function(){
	//1번 단순 submit
	//$('#imageboardWriteForm').submit(); //name 속성만 보내진다.
	
	
	//2번 Ajax 통신
	var formData = new FormData($('#imageboardWriteForm')[0]); //Form 객체 생성하는데 0번째 폼객체를 생성 //form 안에 있는 모든것을 객체로 넘겨줄수있다.
	$.ajax({
		type: 'post',
		url: '/spring/imageboard/imageboardWrite',
		enctype: 'muLtipart/form-data', //파일을 넘겨줄때 이런식으로 설정안하면 문자열로 가기때문에...
		processData: false,
		contentType: false,
		data: formData,
		success: function(data){
			alert("이미지 등록 완료");
			location.href = '/spring/imageboard/imageboardList';
		},
		error: function(err){
			console.log(err);
		}
	});
});

/*
processData
  - 기본값은 true
  - 기본적으로 Query String으로 변환해서 보내진다('변수=값&변수=값')
  - 파일 전송시에는 반드시 false 로 해야한다 (formData를 문자열로 변환하지 않는다)
 
contentType
  - 기본적으로 "application/x-www-form-urlencoded; charset=UTF-8"
  - 파일 전송시에는 'multipart/form-data'로 전송이 될 수 있도록 false 로 설정한다.
 */
