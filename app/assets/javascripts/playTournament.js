
//Making buttons illuminate upon clicks 
$('.player').on('click', function() {
	$allPlayerSpots = $('.player');
	playerPostition = $allPlayerSpots.index($(this))

	if ($(this).hasClass('odd')){
		var otherPlayer = $allPlayerSpots.get(playerPostition-1)
	}
	else if ($(this).hasClass('even')){
		var otherPlayer = $allPlayerSpots.get(playerPostition+1)
	}
	$(this).css('background-color', 'green')
	$(otherPlayer).css('background-color', 'red');

	//Special case, illuminate champion spot upon chooing victor of finals 
	var winnerPosition = $allPlayerSpots.length-1;
	if (playerPostition+1 == winnerPosition || playerPostition+2 == winnerPosition) {
		var winner = $allPlayerSpots.get(winnerPosition);
		$(winner).css('background-color', 'green');
	}

});

