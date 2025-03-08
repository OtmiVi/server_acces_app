class RemoveUserIdFromReferrals < ActiveRecord::Migration[8.0]
  def change
    remove_reference :referrals, :user, foreign_key: true
  end
end