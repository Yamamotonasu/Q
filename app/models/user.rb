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

class User < ApplicationRecord
  attr_accessor :remember_token
  has_one_attached :image
  attribute :new_image
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :name, presence: true, null: false, uniqueness: true,
            length: { maximu: 15, minimum: 2 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :prefecture, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 10 }
  validates :sex, presence: true
  enum prefecture: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
  enum sex: {男:0, 女:1}
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
