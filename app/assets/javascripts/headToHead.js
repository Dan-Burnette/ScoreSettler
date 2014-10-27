//Update the head to head table 
function changeEventHandler(event) {

	var groupId = $('.group-id').val();
	var user1 = $('.user-1').val();
	var user2 = $('.user-2').val();

	var JSON = {user_1 : user1,
				user_2 : user2,
				head_to_head : "true"};

	$.ajax({
		url: '/groups/' + groupId,
		dataType: 'json',
		type: 'GET',
		data: JSON
	})
	$('.head-to-head').show();

	// $.get( "/groups/" + groupId + 'head_to_head', function( data ) {
 //  		$( ".result" ).html( data );
 // 	 		alert( "Load was performed." );
 // 	 		console.log(data);
	// 	});

}	