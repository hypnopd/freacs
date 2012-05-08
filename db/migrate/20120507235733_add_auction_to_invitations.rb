class AddAuctionToInvitations < ActiveRecord::Migration
  def change
    change_table :invitations do |t|
      t.references :auction, :null => false
    end
  end
end
