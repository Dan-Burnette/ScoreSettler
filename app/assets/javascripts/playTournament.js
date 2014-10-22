
//Making buttons illuminate upon clicks 
$('.player').on('click', function() {
	var $allPlayerSpots = $('.player');
	var tournamentSize = ($allPlayerSpots.size()+1)/2;
	var playerPosition = $allPlayerSpots.index($(this))

	if ($(this).hasClass('odd')){
		var otherPlayer = $allPlayerSpots.get(playerPosition-1)
	}

	else if ($(this).hasClass('even')){
		var otherPlayer = $allPlayerSpots.get(playerPosition+1)
	}
	$(this).css('background-color', 'green')
	$(otherPlayer).css('background-color', 'red');

//////////////////
	if (tournamentSize == 4){
		var $roundTwoSpots = $allPlayerSpots.slice(4,6);
		var winnerPosition = $allPlayerSpots.length-1;
		var winner = $allPlayerSpots.get(winnerPosition);
		if (playerPosition == 0 || playerPosition == 1){
			var spotToFill = $roundTwoSpots.get(0);
		}
		else if (playerPosition == 2 || playerPosition == 3){
			var spotToFill = $roundTwoSpots.get(1);
		}
		else if(playerPosition == 4 || playerPosition == 5){
			var spotToFill = winner;
		}
	}
	else if (tournamentSize == 8){

	}
	else if (tournamentSize == 16){
		//fill in later
	}

/////////////////
	var playerName = $(this).text();
	$(spotToFill).text(playerName);
	//Special case, illuminate champion spot upon choosing victor of finals 
	if (playerPosition+1 == winnerPosition || playerPosition+2 == winnerPosition) {
		$(winner).css('background-color', 'green');

	}

});

