$(document).ready(function() 
    { 
        $(".stats-table").tablesorter(); 
    } 
); 


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

// Hover for the table to indicate you can click to sort
$('.sortable').mouseover(function(){
    $(this).addClass('highlight');
}).mouseout(function(){
    $(this).removeClass('highlight');
});