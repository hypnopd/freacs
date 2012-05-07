class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :percentage, :min, :max
      t.references :auction, :null => false
      t.timestamps
    end
  end
end
