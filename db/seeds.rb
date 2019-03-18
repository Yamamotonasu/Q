# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Question.create(content: "今日のお昼ご飯は？", num_one: "焼き肉", num_two: "お寿司", user_id: "3")
Question.create(content: "今日の晩ご飯は？", num_one: "松屋", num_two: "マクド", user_id: "4")
Question.create(content: "今日の朝ご飯は？", num_one: "パン", num_two: "白いごはん", user_id: "5")
Question.create(content: "どっちが好き？", num_one: "松屋", num_two: "すき家", user_id: "7")
Question.create(content: "どっちが好き？", num_one: "大阪", num_two: "東京", user_id: "9")
Question.create(content: "どっちが好き？", num_one: "ダウン", num_two: "コート", user_id: "1")
Question.create(content: "どの言語が好き？", num_one: "Ruby", num_two: "Python", num_three: "Java", num_four: "Javascript", user_id: "2")
Question.create(content: "どっちのフレームワーク？", num_one: "Ruby on Rails", num_two: "Laravel", user_id: "8")
