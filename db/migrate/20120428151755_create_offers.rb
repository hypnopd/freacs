class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :value, :null => false
      t.references :offerable, :polymorphic => true
      t.references :auction_user
      t.timestamps
    end
  end
end
