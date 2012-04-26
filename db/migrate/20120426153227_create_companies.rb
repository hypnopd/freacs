class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :null => false
      t.integer :ico
      t.integer :dic
      t.string :address
      t.string :city
      t.string :phone
      t.timestamps
    end
  end
end
