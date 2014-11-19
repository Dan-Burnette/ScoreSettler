//Accept a group invitation
$('.accept-invite').on('click', function() {
	var userId = $('.user-id').val();
	var groupId = $('.group-id').val();
	var membershipId = $('.membership-id').val();
	var JSON = {user_id : userId,
				group_id : groupId,
				status : "active"
				}

		$.ajax({
			url: '/memberships/' + membershipId  ,
			dataType: 'json',
			type: 'PUT',
			data: JSON
		})
	window.location.reload(true);
})

$('.delete-group').on('click', function() {
	var groupId = $(this).val();
	$.ajax({
		url: '/groups/' + groupId,
		dataType: 'json',
		type: 'DELETE',
		data: JSON
	})
	window.location.reload();
})


