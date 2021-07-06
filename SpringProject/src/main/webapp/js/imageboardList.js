$(document).ready(function() {
	$.ajax({
		type : 'post',
		url : '/spring/imageboard/getImageboardList',
		data: 'pg='+$('#pg').val(),
		dataType : 'json',
		success : function(data) {
			console.log(data);
			
			 $.each(data.list, function(index,items){
	            $('<tr/>').append($('<td/>',{text:items.seq}).prepend($('<input/>',{
	               align: 'center',
	               type: 'checkbox',
	               name: 'select',
	            }))).append($('<td/>').append($('<a/>',{
					   }).append($('<img/>',{
						   src: '../storage/'+items.image1,
						   align: 'center',
						   width: '80px',
						   height: '80px'
				})))).append($('<td/>',{
	               align: 'center',
	               text: items.imageName
	            })).append($('<td/>',{
	               align: 'center',
	               text: items.imagePrice
	            })).append($('<td/>',{
	               align: 'center',
	               text: items.imageQty
	            })).append($('<td/>',{
		               align: 'center',
		               text: (items.imagePrice*items.imageQty)
	            })).appendTo($('#imageboardListTable'));
			});// each

			//페이징 처리                                                         //getPagingHTML()하고 같은거
			$('#imageboardPagingDiv').html(data.imageboardPaging.pagingHTML);
			
		},
		error : function(err) {
			console.log(err);
		}
	});
});