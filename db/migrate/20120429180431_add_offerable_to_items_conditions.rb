class AddOfferableToItemsConditions < ActiveRecord::Migration
  def change
    change_table :offers do |t|
      t.references :offerable, :polymorphic => true
    end
  end
end
