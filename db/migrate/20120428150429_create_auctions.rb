class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name, :phase, :null => false
      t.integer :total_price_weight
      t.boolean :rank, :best_price, :computing_criteria, :default => false
      t.timestamps
    end
  end
end
