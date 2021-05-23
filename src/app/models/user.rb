class User < ApplicationRecord
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
end
