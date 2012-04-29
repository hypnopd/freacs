class CreateAuctionUsers < ActiveRecord::Migration
  def change
    create_table :auction_users do |t|
      t.references :user
      t.references :auction
      t.timestamps
    end
  end
end
