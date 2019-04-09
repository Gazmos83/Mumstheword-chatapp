class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]/i
  validates :email, presence: true, length: {maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX},
                                    uniqueness: {case_sensitive: false }
  has_secure_password

  # Returns the hash digest of the given string of a hash method
  # Cost is written to use mim cost params in tests and high cost params in production
  # This speeds up test render without reducing security features
 def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
   BCrypt::Password.create(string, cost: cost)
 end
 #def User.new_token
  # SecureRandom.urlsafe_base64
 #end
end
