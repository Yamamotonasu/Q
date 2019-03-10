# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :name, presence: true, null: false, uniqueness: true,
            length: { maximu: 15, minimum: 4 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

end
