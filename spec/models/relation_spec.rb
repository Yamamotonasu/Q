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
#  user_id          :bigint(8)
#
# Indexes
#
#  index_relations_on_question_id  (question_id)
#  index_relations_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Relation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
