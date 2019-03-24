# == Schema Information
#
# Table name: answers
#
#  id             :bigint(8)        not null, primary key
#  answer_result  :string           not null
#  target         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  answer_id      :integer
#  answer_post_id :integer
#  question_id    :bigint(8)
#  user_id        :bigint(8)
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
