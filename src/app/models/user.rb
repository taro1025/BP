class User < ApplicationRecord
  #userに持たせるやつ
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :likes
  has_many :posts

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  #validates :profile_text, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

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

  #パスワードのauthenticateとは別物だよ！こっちはクッキー, emailのトークン。
  def authenticated?(token, attribute)
    digest = send("#{attribute}_digest")
    #digestがないとき例外を出してしまうのでfalseを返す
    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end

  #ログアウトするときに使うよ
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
