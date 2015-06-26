class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  
  # validates(:name, presence: true) と同じ
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  #gem bcrypt-ruby
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    #to_sメソッドを呼び出しているのは、nilトークンを扱えるようにするためです。ブラウザでnilトークンが発生することはあってはなりませんが、テスト中に発生することはありえるためです
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    #インデントを1段深くしてあります (経験上、こうしておくことをお勧めします)。

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
