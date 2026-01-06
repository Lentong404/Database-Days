// Queries
//1. Character with the highest level
db.Characters.find().sort({"Stats.Level":-1}).limit(1)

//2. Characters in Faction Jack Ravens or Polaris
db.Characters.find({Faction: {$in:["Jack Ravens","Polaris"]}})

//3. Characters that have more than 30 Gold
db.Characters.find({"Inventory.Gold":{$gt:30}})

//4. Sort by Highest level character
db.Characters.find().sort({"Stats.Level":-1})

//5. Find all items that are not consumables and sort sell price from highest price to lowest
db.Items.find({Type:{$ne:"Consumable"}}).sort({"Sell Cost":-1})



// Update a player’s level and coins (0 is Index number 1)
db.Characters.updateOne({name:"Shuli"},{$set:{"Inventory.0.Gold":50,"Stats.Level":50}})

// Delete one User
db.Users.deleteOne({name: "Loran"})

// Index
db.Users.createIndex({name: 1})
