# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  age             :string           not null
#  charged         :boolean          default(FALSE), not null
#  email           :string
#  name            :string           not null
#  password_digest :string
#  prefecture      :integer          not null
#  remember_digest :string
#  sex             :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  # it "ファクトリが有効かどうか" do
  #   expect(FactoryBot(:user)).to be_valid
  # end
end
