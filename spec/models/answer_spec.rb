# == Schema Information
#
# Table name: answers
#
#  id             :bigint(8)        not null, primary key
#  target         :boolean          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  answer_post_id :integer          not null
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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
