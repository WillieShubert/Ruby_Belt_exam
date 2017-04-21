class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas
  has_many :likes
  has_many :liked_ideas, :through => :like
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :name, :username, presence: true
end
