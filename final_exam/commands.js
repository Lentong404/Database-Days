db.appointments.find({"stylist.name":"Grace"})
db.appointments.find({services:"Color"})
db.appointments.find().sort({appointment_date:-1}).limit(3)
db.appointments.find({}, {"client.name":1, confirmed:1, _id:0})

// Update / Delete
db.appointments.updateOne({"client.name": "Emily"},  {$set:{confirmed: true}})
db.appointments.deleteOne({"client.name": "Daniel", confirmed: false})
// or 
db.appointments.deleteOne({
    appointment_date:{$lt: new Date()},
    confirmed: false
});

// Multi Document
db.appointments.deleteMany({
    appointment_date:{$lt: new Date()},
    confirmed: false
    
});
// 