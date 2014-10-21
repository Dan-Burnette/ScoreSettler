dan = User.new
dan.email = "dan@dan.com"
dan.username = "Dan"
dan.password = "dingusdan"
dan.save!

bill = User.new
bill.email = "bill@bill.com"
bill.username = "bill"
bill.password = "billybob"
bill.save!

bilbo = User.new
bilbo.email = "bilbo@bilbo.com"
bilbo.username = "bilbo"
bilbo.password = "bilbobaggins"
bilbo.save!

spagett = User.new
spagett.email = "spagett@spagett.com"
spagett.username = "spagett"
spagett.password = "spookedya"
spagett.save!


MKS = Group.create(name: "MKS Gamers", admin_id: 1)
MKS.memberships.create(user_id: dan.id)
MKS.memberships.create(user_id: bill.id)
MKS.memberships.create(user_id: bilbo.id)
MKS.memberships.create(user_id: spagett.id)

#4 person test tourney
completedTourney = MKS.tournaments.create(game_type: "Smash Bros", name: "MKS CompletedTourney", champion_id: 3)
t1match1 = completedTourney.matches.create(player_1: 1, player_2: 2, winner_id: 1)
t1match2 = completedTourney.matches.create(player_1: 3, player_2: 4, winner_id: 3)
t1match3 = completedTourney.matches.create(player_1: 1, player_2: 3, winner_id: 3)

#4 person test tourney
inProgressTourney = MKS.tournaments.create(game_type: "Smash Bros", name: "MKS TourneyInProgress")
t1match1 = inProgressTourney.matches.create(player_1: 1, player_2: 2, winner_id: 2)
t1match2 = inProgressTourney.matches.create(player_1: 3, player_2: 4, winner_id: 4)
#Final round not yet played!


GroupToJoin = Group.create(name: "TestGroup1", admin_id: 1)
GroupToJoin.memberships.create(user_id: dan.id)