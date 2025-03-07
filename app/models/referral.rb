class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :server
  before_create :generate_token

  validates :token, uniqueness: true

  private

  def generate_token
    loop do
      self.token = SecureRandom.urlsafe_base64(16)
      break unless Referral.exists?(token: token)
    end
  end
end