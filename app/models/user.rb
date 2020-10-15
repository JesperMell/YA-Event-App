class User < ApplicationRecord
  ROLE_USER = 1
  ROLE_ADMIN = 2

  has_many :comments

  has_many :event_users
  has_many :events, through: :event_users

  has_secure_password

  def admin?
    role_id == ROLE_ADMIN
  end
end
