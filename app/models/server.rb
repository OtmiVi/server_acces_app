class Server < ApplicationRecord
  belongs_to :user
  #encrypts :password
  validates :name, :username, :host, :password, presence: true
end