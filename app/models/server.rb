class Server < ApplicationRecord
  has_many :servers_users, dependent: :destroy
  has_many :users, through: :servers_users
  has_many :referrals, dependent: :destroy
  # encrypts :password
  validates :name, :username, :host, :password, presence: true
end
