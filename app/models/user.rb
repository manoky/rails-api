class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true
  validates_length_of :password_digest, minimum: 8, too_short: 'password is shorter than 8 characters'
  has_secure_password
end
