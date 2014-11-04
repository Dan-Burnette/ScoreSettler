// When selector changes, get server data for updating the head to head table via AJAX request
function changeEventHandler(event) {

	var groupId = $('.group-id').val();
	var user1 = $('.user-1').val();
	var user2 = $('.user-2').val();
	var URL = groupId +',' + user1 + ',' + user2;

	$.ajax({
		url: '/head_to_head/' + URL
	})

}	