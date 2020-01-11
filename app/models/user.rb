# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_create :create_remember_token
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }

  has_many :posts

  # Returns a random token.
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_token, nil)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
