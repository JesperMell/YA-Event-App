class Event < ApplicationRecord
  has_many :event_users
  has_many :users, through: :event_users

  has_many :comments

  def add_comment
  end

  def add_user(user)
    return unless user.is_a?(User)

    return if self.users.include?(user)
    self.users << user

    save
  end

  def remove_user(user)
    return unless user.is_a?(User)

    self.users.delete(user)

    save
  end
end
