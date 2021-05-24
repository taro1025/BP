class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :likes
  has_many :posts

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  #validates :profile_text, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  def User.digest(string)
    #ローカルだからコストを最低にしてるよ！
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #ランダムの文字列の生成とそれをハッシュ化したのをDBに格納するよ
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    #remember_digestがないとき例外を出してしまうのでfalseを返す
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #ログアウトするときに使うよ
  def forget
    update_attribute(:remember_digest, nil)
  end
end
