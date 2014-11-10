// FOR DOUBLE ELIMINATION TOURNAMENTS
//Making buttons illuminate upon clicks appropriately and send AJAX to 
//server to update the state of the tournament
//"de" short for double eliminaton in classes in the view DE views
var loserBracketChampWins = 0;
var onLastMatch = false;
var playedExtraMatch = false;
$('.player-de').on('click', function() {

  var $allPlayerSpots = $('.player-de');
  if ($allPlayerSpots.size() == 13){
    var tournamentSize = 4;
  }
  else if ($allPlayerSpots.size() == 29){
    var tournamentSize = 8;
  }

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
      if (loserBracketChampWins == 1) {
        var match_id = $('.match_7_id').val();
        onLastMatch = true;
      }
      else {
        var match_id = $('.match_6_id').val();
        // var next_match = $('.match_7_id').val();
        onLastMatch = true;
        // var next_match_player = 'player1';
      }
    }
    // Loser bracket champ wins one, must play another match
    else if (playerPosition == 11){
      var spotToFill = winner;
      // You must play another match, display indicator
      if (loserBracketChampWins == 0){
        var match_id = $('.match_6_id').val();
        var next_match = $('.match_7_id').val();
        var next_match_player = 'player2';
        loserBracketChampWins+=1;
        $('.finals').show();
        $('.indicator').text('Loser wins:' + loserBracketChampWins);
      }
      //loserBracketChamp has won tournament
      else if (loserBracketChampWins == 1){
        loserBracketChampWins+=1;
        var spotToFill = winner;
        var match_id = $('.match_7_id').val();
        var next_match = $('.match_7_id').val();
        var next_match_player = 'player2';
        $('.indicator').text('Loser wins:' + loserBracketChampWins);
        onLastMatch = true;
        playedExtraMatch = true;
      }  
    }
  }
  //8 players logic
  else if (tournamentSize == 8) {
    var $roundTwoSpots = $allPlayerSpots.slice(12,20);
    var $roundThreeSpots = $allPlayerSpots.slice(20,24);
    var $roundFourSpots = $allPlayerSpots.slice(24,26);
    var $roundFiveSpots = $allPlayerSpots.slice(26,28);

    if (playerPosition == 0 || playerPosition == 1) {
      var spotToFill = $roundTwoSpots.get(0);
      var loserSpotToFill = $allPlayerSpots.get(8);
      var match_id = $('.match_1_id').val();
      var next_match = $('.match_7_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 2 || playerPosition == 3) {
      var spotToFill = $roundTwoSpots.get(1);
      var loserSpotToFill = $allPlayerSpots.get(9);
      var match_id = $('.match_2_id').val();
      var next_match = $('.match_7_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 4 || playerPosition == 5) {
      var spotToFill = $roundTwoSpots.get(2);
      var loserSpotToFill = $allPlayerSpots.get(10);
      var match_id = $('.match_3_id').val();
      var next_match = $('.match_8_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 6 || playerPosition == 7) {
      var spotToFill = $roundTwoSpots.get(3);
      var loserSpotToFill = $allPlayerSpots.get(11);
      var match_id = $('.match_4_id').val();
      var next_match = $('.match_8_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 8 || playerPosition == 9) {
      var spotToFill = $roundTwoSpots.get(5);
      var match_id = $('.match_5_id').val();
      var next_match = $('.match_9_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 10 || playerPosition == 11) {
      var spotToFill = $roundTwoSpots.get(7) ;
      var match_id = $('.match_6_id').val();
      var next_match = $('.match_10_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 12 || playerPosition == 13) {
      var spotToFill = $roundThreeSpots.get(0);
      var loserSpotToFill = $allPlayerSpots.get(16);
      var match_id = $('.match_7_id').val();
      var next_match = $('.match_11_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 14 || playerPosition == 15) {
      var spotToFill = $roundThreeSpots.get(1);
      var loserSpotToFill = $allPlayerSpots.get(18);
      var match_id = $('.match_8_id').val();
      var next_match = $('.match_11_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 16 || playerPosition == 17) {
      var spotToFill = $roundThreeSpots.get(2);
      var match_id = $('.match_9_id').val();
      var next_match = $('.match_12_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 18 || playerPosition == 19) {
      var spotToFill = $roundThreeSpots.get(3);
      var match_id = $('.match_10_id').val();
      var next_match = $('.match_12_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 20 || playerPosition == 21) {
      var spotToFill = $roundFiveSpots.get(0);
      var loserSpotToFill = $allPlayerSpots.get(24);
      var match_id = $('.match_11_id').val();
      var next_match = $('.match_14_id').val();
      var next_match_player = 'player1';
    }
    else if (playerPosition == 22 || playerPosition == 23) {
      var spotToFill = $roundFourSpots.get(1) ;
      var match_id = $('.match_12_id').val();
      var next_match = $('.match_13_id').val();
      var next_match_player = 'player2';
    }
    else if (playerPosition == 24 || playerPosition == 25) {
      var spotToFill = $roundFiveSpots.get(1);
      var match_id = $('.match_13_id').val();
      var next_match = $('.match_14_id').val();
      var next_match_player = 'player2';
    }
    // Winner bracket champ beats loser bracket champ
    else if(playerPosition == 26){
     var spotToFill = winner;
     if (loserBracketChampWins == 1) {
       var match_id = $('.match_15_id').val();
       onLastMatch = true;
     }
     else {
       var match_id = $('.match_14_id').val();
       // var next_match = $('.match_7_id').val();
       onLastMatch = true;
       // var next_match_player = 'player1';
     }
    }
    // Loser bracket champ wins one, must play another match
    else if (playerPosition == 27){
      var spotToFill = winner;
      // You must play another match, display indicator
      if (loserBracketChampWins == 0){
        var match_id = $('.match_14_id').val();
        var next_match = $('.match_15_id').val();
        var next_match_player = 'player2';
        loserBracketChampWins+=1;
        $('.finals').show();
        $('.indicator').text('Loser wins:' + loserBracketChampWins);
      }
      //loserBracketChamp has won tournament
      else if (loserBracketChampWins == 1){

        loserBracketChampWins+=1;
        var spotToFill = winner;
        var match_id = $('.match_15_id').val();
        var next_match = $('.match_15_id').val();
        var next_match_player = 'player2';
        $('.indicator').text('Loser wins:' + loserBracketChampWins);
        playedExtraMatch = true;
        onLastMatch = true
      }
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
      if (playerPosition == 27 && (loserBracketChampWins == 0 || loserBracketChampWins == 1) ){
        //Do nothing 
      }
      else {
        $(spotToFill).text(playerName);
      }
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
  else if (loserBracketChampWins == 2) {
    $(winner).css('background-color', 'green');
  }

  // AJAX to update the tournament's matches on the server
  var tournament_id = $('.tournament_id').val();
  var matchWinner = $(this).text(); 

  var matchUpdateJSON = 
    {
      tournament : tournament_id,
      match : match_id,
      winner : matchWinner,
      next_match :next_match,
      next_match_player :next_match_player
    }

  if (whichPlayer == "player1"){  
    if (onLastMatch) {
      matchUpdateJSON.player2 = $(otherPlayer).text();
      matchUpdateJSON.player1 = playerName;
    }
    else {
      matchUpdateJSON.player1 = playerName;
      matchUpdateJSON.player2 = otherPlayerName;
    }
  }
  else if (whichPlayer == 'player2'){
    if (onLastMatch) {
      matchUpdateJSON.player1 = $(otherPlayer).text();
      matchUpdateJSON.player2 = playerName;
    }
    else {
      matchUpdateJSON.player1 = otherPlayerName;
      matchUpdateJSON.player2 = playerName;
    }
  }

  $.ajax({
    url: '/tournaments/' + tournament_id + '/matches/' + match_id,
    dataType: 'json',
    type: 'PUT',
    data: matchUpdateJSON
  })


  // If on the last match, AJAX to update the tournament winner
  if (onLastMatch) {
    console.log("FIRING TOURNAMENT WINNER UPDATE");
    var tournamentUpdateJSON = {winner: $(winner).text()};
    $.ajax({
      url: '/tournaments/' + tournament_id,
      dataType: 'json',
      type: 'PUT',
      data: tournamentUpdateJSON
    })
  }


  


});
