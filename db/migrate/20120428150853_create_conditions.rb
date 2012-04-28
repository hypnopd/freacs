class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :name
      t.string :type
      t.integer :percentage

      t.timestamps
    end
  end
end
