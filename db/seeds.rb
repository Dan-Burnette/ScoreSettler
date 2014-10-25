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

mike = User.new
mike.email = "mike@mike.com"
mike.username = "mike"
mike.password = "spookedya"
mike.save!

billybob = User.new
billybob.email = "billybob@billybob.com"
billybob.username = "billybob"
billybob.password = "spookedya"
billybob.save!

shannon = User.new
shannon.email = "shannon@shannon.com"
shannon.username = "shannon"
shannon.password = "spookedya"
shannon.save!

john = User.new
john.email = "john@john.com"
john.username = "john"
john.password = "spookedya"
john.save!

mrNine = User.new
mrNine.email = "mrNine@mrNine.com"
mrNine.username = "mrNine"
mrNine.password = "spookedya"
mrNine.save!


guy = User.new
guy.email = "guy@guy.com"
guy.username = "guy"
guy.password = "guyguyguy"
guy.save!

bob= User.new
bob.email = "bob@bob.com"
bob.username = "bob"
bob.password = "bobbobob"
bob.save!

peach = User.new
peach.email = "peach@peach.com"
peach.username = "peach"
peach.password = "peachpeachpeach"
peach.save!

mario = User.new
mario.email = "mario@mario.com"
mario.username = "mario"
mario.password = "mariomariomario"
mario.save!

bowser = User.new
bowser.email = "bowser@bowser.com"
bowser.username = "bowser"
bowser.password = "bowserbowserbowser"
bowser.save!

#spagett is the not a member
MKS = Group.create(name: "MKS Gamers", admin_id: 1)
MKS.memberships.create(user_id: dan.id, status: "active")
MKS.memberships.create(user_id: bill.id, status: "active")
MKS.memberships.create(user_id: bilbo.id, status: "active")
MKS.memberships.create(user_id: mike.id, status: "active")
MKS.memberships.create(user_id: billybob.id, status: "active")
MKS.memberships.create(user_id: shannon.id, status: "active")
MKS.memberships.create(user_id: john.id, status: "active")
MKS.memberships.create(user_id: mrNine.id, status: "active")
MKS.memberships.create(user_id: bob.id, status: "active")
MKS.memberships.create(user_id: peach.id, status: "active")
MKS.memberships.create(user_id: mario.id, status: "active")
MKS.memberships.create(user_id: bowser.id, status: "active")

GroupToJoin = Group.create(name: "UIOWA Gamers", admin_id: 1)
GroupToJoin.memberships.create(user_id: bob.id, status: "active")
GroupToJoin.memberships.create(user_id: peach.id, status: "active")
GroupToJoin.memberships.create(user_id: mario.id, status: "active")
GroupToJoin.memberships.create(user_id: bowser.id, status: "active")

