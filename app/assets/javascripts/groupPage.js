$(document).ready(function() 
    { 
        $(".stats-table").tablesorter(); 
    } 
); 


$('.head-to-head-submit').on('click', function() {
	
})

$('.invite-user').on('click', function() {
	var username = $('.user-to-invite').val();
	var group_id = $('.group-id').val();
	console.log(group_id);
	var JSON = {username : username,
				group_id : group_id};
	$.ajax({
		url: '/invite',
		dataType: 'json',
		type: 'PUT',
		data: JSON
	})

})