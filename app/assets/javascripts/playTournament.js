//Load up the tournament!
$(document).on('ready', function() {
	
})


//////





//Making buttons illuminate upon clicks appropriately and send AJAX to 
//server to update the state of the tournament

$('.player').on('click', function() {
	var onLastMatch = false;
	var $allPlayerSpots = $('.player');
	var tournamentSize = ($allPlayerSpots.size()+1)/2;
	var playerPosition = $allPlayerSpots.index($(this));

	//Find the other player in that match
	if ($(this).hasClass('odd')){
		var otherPlayer = $allPlayerSpots.get(playerPosition-1);
		var whichPlayer = 'player2';
	}

	else if ($(this).hasClass('even')){
		var otherPlayer = $allPlayerSpots.get(playerPosition+1);
		var whichPlayer = 'player1'
	}
	$(this).css('background-color', 'green');
	$(otherPlayer).css('background-color', 'red');

//////////////////
	var winnerPosition = $allPlayerSpots.length-1;
	var winner = $allPlayerSpots.get(winnerPosition);
	if (tournamentSize == 4){
		var $roundTwoSpots = $allPlayerSpots.slice(4,6);
		if (playerPosition == 0 || playerPosition == 1){
			var spotToFill = $roundTwoSpots.get(0);
			var match_id = $('.match_1_id').val();
		}
		else if (playerPosition == 2 || playerPosition == 3){
			var spotToFill = $roundTwoSpots.get(1);
			var match_id = $('.match_2_id').val();
		}
		else if(playerPosition == 4 || playerPosition == 5){
			var spotToFill = winner;
			var match_id = $('.match_3_id').val();
			onLastMatch = true;
		}
	}
	else if (tournamentSize == 8){
		var $roundTwoSpots = $allPlayerSpots.slice(8,12);
		var $roundThreeSpots = $allPlayerSpots.slice(12,14);
		if (playerPosition == 0 || playerPosition == 1) {
			var spotToFill = $roundTwoSpots.get(0);
			var match_id = $('.match_1_id').val();
		}
		else if (playerPosition == 2 || playerPosition == 3) {
			var spotToFill = $roundTwoSpots.get(1);
			var match_id = $('.match_2_id').val();
		}
		else if (playerPosition == 4 || playerPosition == 5) {
			var spotToFill = $roundTwoSpots.get(2);
			var match_id = $('.match_3_id').val();
		}
		else if (playerPosition == 6 || playerPosition == 7) {
			var spotToFill = $roundTwoSpots.get(3);
			var match_id = $('.match_4_id').val();
		}
		else if (playerPosition == 8 || playerPosition == 9) {
			var spotToFill = $roundThreeSpots.get(0);
			var match_id = $('.match_5_id').val();
		}
		else if (playerPosition == 10 || playerPosition == 11) {
			var spotToFill = $roundThreeSpots.get(1);
			var match_id = $('.match_6_id').val();
		}
		else if (playerPosition == 12 || playerPosition == 13) {
			var spotToFill = winner;
			var match_id = $('.match_7_id').val();
			onLastMatch = true;
		}
	}
	else if (tournamentSize == 16){
		//fill in later once I make that view
		//////////////////////////////////////////////
		//////////////////////////////////////////////
		//////////////////////////////////////////////
	}

	var playerName = $(this).text();
	var otherPlayerName = $(otherPlayer).text();
	if (playerName != 'bye'){
		$(spotToFill).text(playerName);
	}
	//Stop bye from displaying as a winner
	else {
		$(spotToFill).text(otherPlayerName);
			$(this).css('background-color', 'red');
			$(otherPlayer).css('background-color', 'green');
	}


	//Special case, illuminate champion spot upon choosing victor of finals 
	if (playerPosition+1 == winnerPosition || playerPosition+2 == winnerPosition) {
		$(winner).css('background-color', 'green');
	}

	//AJAX to update the tournament's matches on the server
	var tournament_id = $('.tournament_id').val();
	var matchWinner = $(spotToFill).text(); 
	var matchUpdateJSON = 
		{
			tournament : tournament_id,
			match : match_id,
			winner : matchWinner
		}

	if (whichPlayer == "player1"){	
		matchUpdateJSON.player1 = playerName;
		matchUpdateJSON.player2 = otherPlayerName;
	}
	else if (whichPlayer == 'player2'){
		matchUpdateJSON.player1 = otherPlayerName;
		matchUpdateJSON.player2 = playerName;
	}

	console.log(matchUpdateJSON);

	$.ajax({
		url: '/tournaments/' + tournament_id + '/matches/' + match_id,
		dataType: 'json',
		type: 'PUT',
		data: matchUpdateJSON
	})

	//If on the last match, AJAX to update the tournament winner
	if (onLastMatch){
		var tournamentUpdateJSON = {winner: $(winner).text()};
		console.log(tournamentUpdateJSON);
		$.ajax({
			url: '/tournaments/' + tournament_id,
			dataType: 'json',
			type: 'PUT',
			data: tournamentUpdateJSON
		})
	}

});

