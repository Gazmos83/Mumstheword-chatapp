# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
<<<<<<< HEAD
User.create!(name:  "Mr Le Pew",
             email: "kevin.louis.dath@gmail.com",
             password:              "123456",
             password_confirmation: "123456")
=======
User.create!(name:  "Pingu",
             email: "chimericano@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true)
>>>>>>> updating-users

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@nunyabidness.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
