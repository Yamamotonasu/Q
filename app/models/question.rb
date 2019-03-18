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

class Question < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 4, maximum: 200 }
  validates :num_one, presence: true, length: { maximum: 50 }
  validates :num_two, presence: true, length: { maximum: 50 }
  default_scope -> { order(created_at: :desc) }
  # validates_uniqueness_of :question_id, scope: :user_id
end
