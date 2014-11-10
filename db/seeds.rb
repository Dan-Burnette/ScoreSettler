dan = User.new
dan.email = "dan@dan.com"
dan.username = "dan"
dan.password = "dingusdan"
dan.save!

yusef = User.new
yusef.email = "yusef@yusef.com"
yusef.username = "yusef"
yusef.password = "yusefyusefyusef"
yusef.save!

nick = User.new
nick.email = "nick@nick.com"
nick.username = "nick"
nick.password = "nicknicknick"
nick.save!

marco = User.new
marco.email = "marco@marco.com"
marco.username = "marco"
marco.password = "marcomarcomarco"
marco.save!

gilbert = User.new
gilbert.email = "gilbert@gilbert.com"
gilbert.username = "gilbert"
gilbert.password = "gilbertgilbertgilbert"
gilbert.save!

bradley = User.new
bradley.email = "bradley@bradley.com"
bradley.username = "bradley"
bradley.password = "bradleybradleybradley"
bradley.save!

darrell = User.new
darrell.email = "darrell@darrell.com"
darrell.username = "darrell"
darrell.password = "darrelldarrelldarrell"
darrell.save!

ben = User.new
ben.email = "ben@ben.com"
ben.username = "ben"
ben.password = "benbenben"
ben.save!

billyBob = User.new
billyBob.email = "BillyBob@BillyBob.com"
billyBob.username = "BillyBob"
billyBob.password = "BillyBobBillyBobBillyBob"
billyBob.save!


MKS = Group.create(name: "MKS Gamers", admin_id: 1)
MKS.memberships.create(user_id: dan.id, status: "active")
MKS.memberships.create(user_id: yusef.id, status: "active")
MKS.memberships.create(user_id: nick.id, status: "active")
MKS.memberships.create(user_id: marco.id, status: "active")
MKS.memberships.create(user_id: gilbert.id, status: "active")
MKS.memberships.create(user_id: bradley.id, status: "active")
MKS.memberships.create(user_id: darrell.id, status: "active")
MKS.memberships.create(user_id: ben.id, status: "active")
MKS.memberships.create(user_id: billyBob.id, status: "active")



