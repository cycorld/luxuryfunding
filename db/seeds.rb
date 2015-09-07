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
md_book = Book.create(user_id: user.id, title: "MD Vocabulary 33000", intro: "영어 문장 암기")
chin_book = Book.create(user_id: user.id, title: "친 중국어", intro: "중국어 암기")

Dir.glob('./db/md_voca/*.csv').each_with_index do |csv, i|
  chap = Chapter.create(book_id: md_book.id, title: "Day #{i+1}")
  CSV.foreach(csv, {headers: true}) do |r|
    Card.create(chapter_id: chap.id, question: r["answer"], answer: r["question"], a_lang: "en")
  end
end

Dir.glob('./db/chin_chinese/*.csv').each_with_index do |csv, i|
  chap = Chapter.create(book_id: chin_book.id, title: "Day #{i+1}")
  CSV.foreach(csv, {headers: true}) do |r|
    Card.create(chapter_id: chap.id, question: r["answer"], answer: r["question"], a_lang: "zh")
  end
end
