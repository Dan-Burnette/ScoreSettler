$(document).ready(function() 
    { 
        $(".stats-table").tablesorter({
     		 sortList: [[4,1]] 
        }); 
    } 
); 


//Send AJAX to invite a user on click
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


//Keeping track of how many player checkboxes are selected
var playersSelected = 0;
$('.check').on('click', function() {
	if ($(this).is(':checked')) {
		playersSelected++;
	 }
	 else {
	 	playersSelected--;
	 }
	 $('.player-counter').text("Players selected: " + playersSelected);
})

// Hover for the table to indicate you can click to sort
$('.sortable').mouseover(function(){
    $(this).addClass('highlight');
}).mouseout(function(){
    $(this).removeClass('highlight');
});