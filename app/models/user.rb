# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string           not null
#  password_digest :string
#  remember_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_accessor :remember_token
  has_one_attached :image
  attribute :new_image
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :name, presence: true, null: false, uniqueness: true,
            length: { maximu: 15, minimum: 4 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate  :file_validation, if: -> { image.attached? }
  has_secure_password

  before_save do
    self.image = new_image if new_image
  end

  class << self
  # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションの為にnew_tokenメソッドでランダムなトークンを生成し、データベースに登録する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがremember_digestの値と一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # ファイルのアップロードサイズのバリデーション
  def file_validation
    if image.blob.byte_size > 1_000_000
      file_raise_error('のファイル容量が大きすぎます')
    elsif !image.blob.content_type.starts_with?('image/')
      file_raise_error('は、画像以外はアップロード出来ません')
    end
  end

  def file_raise_error(message)
    image.purge
    errors.add(:avatar, message)
  end

end
