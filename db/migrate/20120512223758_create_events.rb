class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :auction, :null => false
      t.timestamps
    end
  end
end
