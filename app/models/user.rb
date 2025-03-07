class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :servers, dependent: :destroy
  has_many :referrals, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end