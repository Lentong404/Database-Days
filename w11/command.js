// Made Database 
use carRentalDB

// Create Collection
db.createCollection("cars")

// Insert one 
db.cars.insertOne({
    "brand": "Toyota",
    "model": "Corolla",
    "year": 2022,
    "pricePerDay": 45.99,
    "available": true
})

// Insert many 
db.cars.insertMany([
    { "brand": "Honda", "model": "Civic", "year": 2021, "pricePerDay": 50.00, "available": false },
    { "brand": "Ford", "model": "Focus", "year": 2020, "pricePerDay": 40.00, "available": true }
])

// Verify
db.cars.find()

// Create Collection
db.createCollection("customers")

// Insert one 
db.customers.insertOne({
    "name": "Alice Wood",
    "age": 32,
    "membershipStartDate": new Date("2019-06-15"),
    "lastRentalDate": new Date(),
    "preferredCarTypes": ["SUV", "Sedan"],
    "contact": {
        "email": "alice@example.com",
        "phone": "+1-555-1234"
    }
})

// Insert many 
db.customers.insertMany([
    {
        "name": "Bob Green",
        "age": 45,
        "membershipStartDate": new Date("2017-03-10"),
        "lastRentalDate": new Date(),
        "preferredCarTypes": ["Convertible"],
        "contact": { "email": "bob@example.com", "phone": "+1-555-5678" }
    },
    {
        "name": "Emily Johnson",
        "age": 27,
        "membershipStartDate": new Date("2021-09-21"),
        "lastRentalDate": new Date(),
        "preferredCarTypes": ["Hatchback", "Electric"],
        "contact": { "email": "emily@example.com", "phone": "+1-555-9876" }
    }
])

// Verify
db.customers.find()