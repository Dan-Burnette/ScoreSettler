
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
	var winnerPosition = $allPlayerSpots.length-1;
	var winner = $allPlayerSpots.get(winnerPosition);
	if (tournamentSize == 4){
		var $roundTwoSpots = $allPlayerSpots.slice(4,6);
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
		var $roundTwoSpots = $allPlayerSpots.slice(8,12);
		var $roundThreeSpots = $allPlayerSpots.slice(12,14);
		if (playerPosition == 0 || playerPosition == 1) {
			var spotToFill = $roundTwoSpots.get(0);
		}
		else if (playerPosition == 2 || playerPosition == 3) {
			var spotToFill = $roundTwoSpots.get(1);
		}
		else if (playerPosition == 4 || playerPosition == 5) {
			var spotToFill = $roundTwoSpots.get(2);
		}
		else if (playerPosition == 6 || playerPosition == 7) {
			var spotToFill = $roundTwoSpots.get(3);
		}
		else if (playerPosition == 8 || playerPosition == 9) {
			var spotToFill = $roundThreeSpots.get(0);
		}
		else if (playerPosition == 10 || playerPosition == 11) {
			var spotToFill = $roundThreeSpots.get(1);
		}
		else if (playerPosition == 12 || playerPosition == 13) {
			var spotToFill = winner;
		}
	}
	else if (tournamentSize == 16){
		//fill in later once I make that view
		//////////////////////////////////////////////
		//////////////////////////////////////////////
		//////////////////////////////////////////////
	}

	var playerName = $(this).text();
	$(spotToFill).text(playerName);

	//Special case, illuminate champion spot upon choosing victor of finals 
	if (playerPosition+1 == winnerPosition || playerPosition+2 == winnerPosition) {
		$(winner).css('background-color', 'green');

	}

});

