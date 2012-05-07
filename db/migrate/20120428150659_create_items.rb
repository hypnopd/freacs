class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.text :description
      t.string :unit, :null => false
      t.float :amount, :null => false
      t.references :auction, :null => false
      t.integer :min, :max
      t.timestamps
    end
  end
end
