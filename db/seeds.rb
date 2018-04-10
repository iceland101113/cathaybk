# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Card.create(:title => "9:00~10:30")
Card.create(:title => "10:30~12:00")
Card.create(:title => "13:30~15:00")
Card.create(:title => "15:00~16:30")
puts "Have create 4 card"