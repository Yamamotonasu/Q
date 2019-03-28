# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "john", password: "foobarbaz", prefecture: "大阪府", age: 27, sex: "男")
User.create(name: "akari", password: "foobarbaz", prefecture: "京都府", age: 52, sex: "女")
User.create(name: "yuuki", password: "foobarbaz", prefecture: "滋賀県", age: 14, sex: "女")
User.create(name: "nakano", password: "foobarbaz", prefecture: "東京都", age: 32, sex: "男")
User.create(name: "hori", password: "foobarbaz", prefecture: "山梨県", age: 42, sex: "女")
User.create(name: "QueA", password: "foobarbaz", prefecture: "千葉県", age: 22, sex: "男")
User.create(name: "test1", password: "foobarbaz", prefecture: "三重県", age: 25, sex: "男")
User.create(name: "test2", password: "foobarbaz", prefecture: "東京都", age: 81, sex: "女")
User.create(name: "test3", password: "foobarbaz", prefecture: "山口県", age: 69, sex: "女")
User.create(name: "test4", password: "foobarbaz", prefecture: "兵庫県", age: 35, sex: "男")
User.create(name: "test5", password: "foobarbaz", prefecture: "秋田県", age: 43, sex: "女")
User.create(name: "test6", password: "foobarbaz", prefecture: "埼玉県", age: 51, sex: "男")

Question.create(content: "今日のお昼ご飯は？", num_one: "焼き肉", num_two: "お寿司", user_id: "2", target: true)
Question.create(content: "今日の晩ご飯は？", num_one: "松屋", num_two: "マクド", user_id: "3", target: true)
Question.create(content: "今日の朝ご飯は？", num_one: "パン", num_two: "白いごはん", user_id: "4", target: true)
Question.create(content: "どっちが好き？", num_one: "松屋", num_two: "すき家", user_id: "5", target: true)
Question.create(content: "どっちが好き？", num_one: "大阪", num_two: "東京", user_id: "6", target: true)
Question.create(content: "どっちが好き？", num_one: "ダウン", num_two: "コート", user_id: "3")
Question.create(content: "どの言語が好き？", num_one: "Ruby", num_two: "Python", num_three: "Java", num_four: "Javascript", user_id: "2")
Question.create(content: "この質問は表示されたら駄目だよ？", num_one: "Ruby on Rails", num_two: "Laravel", user_id: "1", target: true)
Question.create(content: "初デートはどこがいい？", num_one: "ディズニーランド", num_two: "映画館", num_three: "ユニバ", num_four: "レゴランド", user_id: "7", target: true)
