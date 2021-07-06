//로그인
$('#loginBtn').click(function(){
	//안의 값을 초기화
	$('#idDiv').empty();
	$('#pwdDiv').empty();
	
	if($('#id').val() == ''){
		$('#idDiv').text("아이디 입력");
		$('#idDiv').css('color', 'red');
		$('#idDiv').css('font-size', '8pt');
		$('#idDiv').css('font-weight', 'bold');
	}else if($('#pwd').val() == ''){
		$('#pwdDiv').text("비밀번호 입력");
		$('#pwdDiv').css('color', 'red');
		$('#pwdDiv').css('font-size', '8pt');
		$('#pwdDiv').css('font-weight', 'bold');
	}else{
	       
		   $.ajax({
		         url:'/spring/member/login',
		         type: 'post',
		         data: {
		               'id': $('#id').val(),
		               'pwd': $('#pwd').val()
		          },
		          dataType: 'text',
		          success: function(data){
		        	  if(data == 'success'){
		        		  location.href='/spring/index.jsp';
		        	  }else{
		        		  alert('로그인 실패');
		        	  }
		        	  
		            },
		          error:function(err){
		            console.log(err);
		            alert('로그인 실패');
		         }      
		      });
		}
	});
	
//회원가입창으로 가기
$('#writeFormBtn').click(function(){
	location.href='/spring/member/writeForm'
});

//회원가입
$('#writeForm #writeBtn').click(function(){
	$('#writeForm #nameDiv').empty();
	$('#writeForm #idDiv').empty();
	$('#writeForm #pwdDiv').empty();
	
	if($('#writeForm #name').val() == ''){
		$('#writeForm #nameDiv').html("이름 입력");
		$('#writeForm #nameDiv').css('color', 'red');
		$('#writeForm #nameDiv').css('font-size', '8pt');
		$('#writeForm #nameDiv').css('font-weight', 'bold');
		
	}else if($('#writeForm #id').val() == ''){
		$('#writeForm #idDiv').html("아이디 입력");
		$('#writeForm #idDiv').css('color', 'red');
		$('#writeForm #idDiv').css('font-size', '8pt');
		$('#writeForm #idDiv').css('font-weight', 'bold');
		
	}else if($('#writeForm #pwd').val() == ''){
		$('#writeForm #pwdDiv').html("비밀번호 입력");
		$('#writeForm #pwdDiv').css('color', 'red');
		$('#writeForm #pwdDiv').css('font-size', '8pt');
		$('#writeForm #pwdDiv').css('font-weight', 'bold');
		
	}else if($('#writeForm #repwd').val() == ''){
		$('#writeForm #pwdDiv').html("재확인 비밀번호 입력");
		$('#writeForm #pwdDiv').css('color', 'red');
		$('#writeForm #pwdDiv').css('font-size', '8pt');
		$('#writeForm #pwdDiv').css('font-weight', 'bold');
		
	}else if($('#writeForm #pwd').val() != $('#writeForm #repwd').val()){
		$('#writeForm #pwdDiv').html("비밀번호가 틀렸습니다");
		$('#writeForm #pwdDiv').css('color', 'red');
		$('#writeForm #pwdDiv').css('font-size', '8pt');
		$('#writeForm #pwdDiv').css('font-weight', 'bold');
		
	}else if($('#writeForm #check').val() != $('#writeForm #id').val()){
		$('#writeForm #idDiv').html("중복체크  하세요");
		$('#writeForm #idDiv').css('color', 'red');
		$('#writeForm #idDiv').css('font-size', '8pt');
		$('#writeForm #idDiv').css('font-weight', 'bold');
		
	}else{
	   $.ajax({
	         url:'/spring/member/write',
	         type: 'post',
	         data: $('#writeForm').serialize(),
	         success: function(){
	               alert('회원가입 등록');
	               location.href = '/spring/index.jsp';
	            },
	         error:function(err){
	            console.log(err);
	            alert('회원가입 실패');
	         }      
	      });
	}
});

//중복 아이디 체크
//$('#checkIdBtn').click(function(){
$('#writeForm #id').focusout(function(){
	$('#writeForm #idDiv').empty();
	
	if($('#writeForm #id').val() == ''){
		$('#writeForm #idDiv').html("먼저 아이디 입력");
		$('#writeForm #idDiv').css('color', 'magenta');
		$('#writeForm #idDiv').css('font-size', '8pt');
		$('#writeForm #idDiv').css('font-weight', 'bold');
	}else{
		$.ajax({
			url: '/spring/member/checkId',
			type: 'post',
			data: 'id='+$('#writeForm #id').val(),
			dataType: 'text',
			success: function(data){
				if(data == 'true'){
					$('#writeForm #idDiv').text('사용 불가능')
					$('#writeForm #idDiv').css('color','red')
					$('#writeForm #idDiv').css('font-size','8pt')
					$('#writeForm #idDiv').css('font-weight','bold');
				}else if(data == 'false'){
					$('#writeForm #idDiv').text('사용 가능')
					$('#writeForm #idDiv').css('color','blue')
					$('#writeForm #idDiv').css('font-size','8pt')
					$('#writeForm #idDiv').css('font-weight','bold');
					
					$('#writeForm #check').val($('#writeForm #id').val());
				}
			},
			error: function(err){
				console.log(err);
			}
		});
	}
});


//우편주소
$('#checkPostBtn').click(function(){
	window.open("/spring/member/checkPost", "checkPost", "width=500 height=500 left=800 top=200 scrollbars=yes");
});


//우편주소찾기
$('#checkPostSearchBtn').click(function(){
	$.ajax({
		url: '/spring/member/checkPostSearch',
		type: 'post',
		data: $('#checkPostForm').serialize(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			//초기화 작업
			$('#checkPostTable tr:gt(2)').remove();
			
			$.each(data.list, function(index, items){ //제이쿼리식 for문
				var address = items.sido + ' ' 
							+ items.sigungu + ' '
							+ items.yubmyundong+' '
							+ items.ri+' '
							+ items.roadname+' '
							+ items.buildingname;
			
				//undefined 을 빈칸으로 만들어주기
				address = address.replace(/null/g, ''); /* 정규식 표현법 */ 
				/* 뒤에 g는 글로벌 내가갖고온 전체에서 라는 뜻 */
				
				$('<tr/>').append( $('<td/>',{
					align: 'center',
					text: items.zipcode
				})).append($('<td/>',{
					colspan: 3,
					}).append($('<a/>',{
						href: '#',
						text: address,
						id: 'addressA'
					}))
				).appendTo($('#checkPostTable'));
			});//each
			
			$('a').click(function(){
				//alert($(this).prop('tagName')); //a태그라고 나와야한다
				//alert($(this).parent().prev().text()); //우편번호가 나온다
				
				$('#zipcode', opener.document).val($(this).parent().prev().text());
				$('#addr1', opener.document).val($(this).text());
				$('#addr2', opener.document).focus();
				window.close();
			});
		},
		error: function(err){
			console.log(err);
		}
	});
});



//회원정보수정
$('#modifyBtn').click(function(){
	$('#nameDiv').empty();
	$('#pwdDiv').empty();
	
	if($('#name').val() == ''){
		$('#nameDiv').html("이름 입력");
		$('#nameDiv').css('color', 'red');
		$('#nameDiv').css('font-size', '8pt');
		$('#nameDiv').css('font-weight', 'bold');
		
	}else if($('#pwd').val() == ''){
		$('#pwdDiv').html("비밀번호 입력");
		$('#pwdDiv').css('color', 'red');
		$('#pwdDiv').css('font-size', '8pt');
		$('#pwdDiv').css('font-weight', 'bold');
		
	}else if($('#repwd').val() == ''){
		$('#pwdDiv').html("재확인 비밀번호 입력");
		$('#pwdDiv').css('color', 'red');
		$('#pwdDiv').css('font-size', '8pt');
		$('#pwdDiv').css('font-weight', 'bold');
		
	}else if($('#pwd').val() != $('#repwd').val()){
		$('#pwdDiv').html("비밀번호가 틀렸습니다");
		$('#pwdDiv').css('color', 'red');
		$('#pwdDiv').css('font-size', '8pt');
		$('#pwdDiv').css('font-weight', 'bold');
		
	}else{
		$('form[name=modifyForm]').submit();
	}
	
});



