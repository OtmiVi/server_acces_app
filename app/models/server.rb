class Server < ApplicationRecord
  has_many :servers_users
  has_many :users, through: :servers_users
  #encrypts :password
  validates :name, :username, :host, :password, presence: true
end