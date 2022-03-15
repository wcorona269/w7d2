class User < ApplicationRecord
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_object, presence: true
  after_initialize :ensure_session_token
  attr_reader :password
  
  def self.find_by_credentials
    user = User.find_by(username:email)
    if user && user.is_password?(password)
      user
    else
      nil
    end 
  end

  def is_password?(password)
    password_object = BCrypt::password.new(self.password_digest)

    password_object.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.new(password)
    p 'in setter'
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64

    self.save!
    self.session_token
  end  
end
