# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
user = User.create(email: "choi@likelion.net", password: "12341234", password_confirmation: "12341234")
box = Box.create(user_id: user.id, title: "MD Vocabulary 33000")

CSV.foreach('db/day1.csv', {headers: true}) do |r|
  Card.create(box_id: box.id, question: r["answer"], answer: r["question"])
end
