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
				group_id : group_id,
				status : "pending"};
	$.ajax({
		url: '/memberships',
		dataType: 'json',
		type: 'POST',
		data: JSON
	})

	$(this).text("Sent!");
	var me = this;
	setTimeout(function(){
		$(me).text("Invite");
	}, 1000);

})