class User < ApplicationRecord

  has_many :homes, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: { message: "이름을 입력해 주십시오!" }
  validates :email, presence: { message: "실제 이메일을 입력해 주십시오!" }, uniqueness: { message: "이미 존재하는 이메일입니다!" }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , :message => "실제 이메일을 입력해 주십시오!"
  validates :password_digest, length: { minimum: 4 ,message: "비밀번호 4자리 이상 입력해 주십시오!" }

  @@existedAdmin = false


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def admin
    if email == 'admin'
      true
    else
      false
    end
  end

  def User.getExistedAdmin
    @@existedAdmin
  end

  def User.setExistedAdmin(value)
    @@existedAdmin = value
  end


  def authenticate(password)
    if password_digest == Digest::SHA1.hexdigest(password)
      true
    else
      false
    end
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
