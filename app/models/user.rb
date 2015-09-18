class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :comments,
    class_name: 'Note',
    foreign_key: :user_id,
    primary_key: :id

  attr_reader :password

  # def self.generate_session_token
  #   self.session_token = SecureRandom.base64
  #   self.save!
  # end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email,password)
    potential_user = User.find_by({email: email})
    return nil unless potential_user.is_password?(password)
    potential_user
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
