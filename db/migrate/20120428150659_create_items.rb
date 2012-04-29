class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :unit
      t.integer :amount
      t.references :auction
      t.timestamps
    end
  end
end
