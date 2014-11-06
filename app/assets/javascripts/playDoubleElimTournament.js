// FOR DOUBLE ELIMINATION TOURNAMENTS
//Making buttons illuminate upon clicks appropriately and send AJAX to 
//server to update the state of the tournament
//"de" short for double eliminaton in classes in the view DE views
var loserBracketChampWins = 0;

$('.player-de').on('click', function() {
  var onLastMatch = false;
  var $allPlayerSpots = $('.player-de');
  var tournamentSize = ($allPlayerSpots.size()-1)/3;
  console.log('size is', tournamentSize);
  var playerPosition = $allPlayerSpots.index($(this));

  //Find the other player in that match
  if ($(this).hasClass('odd')){
    var otherPlayer = $allPlayerSpots.get(playerPosition-1);
    var whichPlayer = 'player2';
  }

  else if ($(this).hasClass('even')){
    var otherPlayer = $allPlayerSpots.get(playerPosition+1);
    var whichPlayer = 'player1';
  }

  $(this).css('background-color', 'green');
  $(otherPlayer).css('background-color', 'red');

//////////////////
  var winnerPosition = $allPlayerSpots.length-1;
  var winner = $allPlayerSpots.get(winnerPosition);
  var winnerBracketChamp = $allPlayerSpots.get(10);
  var loserBracketChamp = $allPlayerSpots.get(11);
  if (tournamentSize == 4){
    var $roundTwoSpots = $allPlayerSpots.slice(6,10);
    var $roundThreeSpots = $allPlayerSpots.slice(10,12);
    if (playerPosition == 0 || playerPosition == 1){
      var spotToFill = $roundTwoSpots.get(0);
      var loserSpotToFill = $allPlayerSpots.get(4);
      var match_id = $('.match_1_id').val();
      var next_match = $('.match_4_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 2 || playerPosition == 3){
      var spotToFill = $roundTwoSpots.get(1);
      var loserSpotToFill = $allPlayerSpots.get(5);
      var match_id = $('.match_2_id').val();
      var next_match = $('.match_4_id').val();
      var next_match_player = 'player2';
    }
    else if(playerPosition == 4 || playerPosition == 5){
      var spotToFill = $roundTwoSpots.get(3);
      var match_id = $('.match_3_id').val();
      var next_match = $('.match_5_id').val();
      var next_match_player = 'player2';
    }
    else if(playerPosition == 6 || playerPosition == 7){
      var spotToFill = $roundThreeSpots.get(0);
      var loserSpotToFill = $allPlayerSpots.get(8);
      var match_id = $('.match_4_id').val();
      var next_match = $('.match_6_id').val();
      var next_match_player = 'player1';
    }
    else if(playerPosition == 8 || playerPosition == 9){
      var spotToFill = $roundThreeSpots.get(1);
      var match_id = $('.match_5_id').val();
      var next_match = $('.match_6_id').val();
      var next_match_player = 'player2';
    }
    // Winner bracket champ beats loser bracket champ
    else if(playerPosition == 10){
      var spotToFill = winner;
      var match_id = $('.match_6_id');
      //Just leave the unplayed match as everything nil
    }
    // Loser bracket champ wins one, must play another match
    else if (playerPosition == 11){
      var spotToFill = winner;
      // You must play another match, display indicator
      if (loserBracketChampWins == 0){
        loserBracketChampWins+=1;
        $('.finals').show();
        $('.indicator').text('Loser wins:' + loserBracketChampWins);
      }
      //loserBracketChamp has won tournament
      else if (loserBracketChampWins == 1){
        loserBracketChampWins+=1;
        var spotToFill = winner;
        var match_id = $('.match_7_id');
      }  
    }

  //8 players logic
  else if (tournamentSize == 8){
    var $roundTwoSpots = $allPlayerSpots.slice(8,12);
    var $roundThreeSpots = $allPlayerSpots.slice(12,14);
    if (playerPosition == 0 || playerPosition == 1) {
      var spotToFill = $roundTwoSpots.get(0);
      var match_id = $('.match_1_id').val();
      var next_match = $('.match_5_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 2 || playerPosition == 3) {
      var spotToFill = $roundTwoSpots.get(1);
      var match_id = $('.match_2_id').val();
      var next_match = $('.match_5_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 4 || playerPosition == 5) {
      var spotToFill = $roundTwoSpots.get(2);
      var match_id = $('.match_3_id').val();
      var next_match = $('.match_6_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 6 || playerPosition == 7) {
      var spotToFill = $roundTwoSpots.get(3);
      var match_id = $('.match_4_id').val();
      var next_match = $('.match_6_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 8 || playerPosition == 9) {
      var spotToFill = $roundThreeSpots.get(0);
      var match_id = $('.match_5_id').val();
      var next_match = $('.match_7_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 10 || playerPosition == 11) {
      var spotToFill = $roundThreeSpots.get(1);
      var match_id = $('.match_6_id').val();
      var next_match = $('.match_7_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 12 || playerPosition == 13) {
      var spotToFill = winner;
      var match_id = $('.match_7_id').val();
      onLastMatch = true;
    }
  }

  var playerName = $(this).text();
  var otherPlayerName = $(otherPlayer).text();
  if (playerName != 'bye'){
    if (tournamentSize == 4) {
      if (playerPosition == 11 && (loserBracketChampWins == 0 || loserBracketChampWins == 1) ){
        //Do nothing 
      }
      else {
        $(spotToFill).text(playerName);
      }
    }
    else if (tournamentSize == 8){

    } 

  }
  //Stop bye from displaying as a winner
  else {
    $(spotToFill).text(otherPlayerName);
    $(this).css('background-color', 'red');
    $(otherPlayer).css('background-color', 'green');
  }
  if (loserSpotToFill) {
    $(loserSpotToFill).text(otherPlayerName);
  } 

  //Special case, illuminate champion spot upon choosing victor of finals 
  if (playerPosition+2 == winnerPosition) {
    $(winner).css('background-color', 'green');
  }
  else if (loserBracketChampWins == 2){
    $(winner).css('background-color', 'green');
  }

  // AJAX to update the tournament's matches on the server
  // var tournament_id = $('.tournament_id').val();
  // var matchWinner = $(spotToFill).text(); 
  // var matchUpdateJSON = 
  //   {
  //     tournament : tournament_id,
  //     match : match_id,
  //     winner : matchWinner,
  //     next_match :next_match,
  //     next_match_player :next_match_player
  //   }

  // if (whichPlayer == "player1"){  
  //   matchUpdateJSON.player1 = playerName;
  //   matchUpdateJSON.player2 = otherPlayerName;
  // }
  // else if (whichPlayer == 'player2'){
  //   matchUpdateJSON.player1 = otherPlayerName;
  //   matchUpdateJSON.player2 = playerName;
  // }

  // console.log(matchUpdateJSON);

  // $.ajax({
  //   url: '/tournaments/' + tournament_id + '/matches/' + match_id,
  //   dataType: 'json',
  //   type: 'PUT',
  //   data: matchUpdateJSON
  // })

  // //If on the last match, AJAX to update the tournament winner
  // if (onLastMatch){
  //   var tournamentUpdateJSON = {winner: $(winner).text()};
  //   console.log(tournamentUpdateJSON);
  //   $.ajax({
  //     url: '/tournaments/' + tournament_id,
  //     dataType: 'json',
  //     type: 'PUT',
  //     data: tournamentUpdateJSON
  //   })
  // }

}
});