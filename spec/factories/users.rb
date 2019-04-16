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

FactoryBot.define do
  factory :user do
    name { "tester" }
    age { "20" }
    charged { "true" }
    prefecture { "大阪府" }
    sex { "女" }
    password { "testtesttest" }
  end
end
