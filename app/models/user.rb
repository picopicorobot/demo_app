class User < ActiveRecord::Base
  has_many :microposts
  validates :name, presence: true, length: { maximum: 50 }
  # validates(:name, presence: true) と同じ
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  #gem bcrypt-ruby
  has_secure_password
end
