# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  num_four   :string
#  num_one    :string           not null
#  num_three  :string
#  num_two    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_questions_on_user_id                 (user_id)
#  index_questions_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :question do
    content { "MyText" }
    num_one { "MyString" }
    num_two { "MyString" }
    num_three { "MyString" }
    num_four { "MyString" }
    user { nil }
  end
end
