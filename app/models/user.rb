class User < ApplicationRecord

  has_many :homes, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
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
