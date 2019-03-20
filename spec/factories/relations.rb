# == Schema Information
#
# Table name: relations
#
#  id               :bigint(8)        not null, primary key
#  target           :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  answered_user_id :integer          not null
#  question_id      :bigint(8)        not null
#
# Indexes
#
#  index_relations_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

FactoryBot.define do
  factory :relation do
    answerd_user_id { 1 }
    question { nil }
  end
end
