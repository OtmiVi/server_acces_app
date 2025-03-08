class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :servers_users
  has_many :servers, through: :servers_users
  has_many :referrals, dependent: :destroy

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end
end
