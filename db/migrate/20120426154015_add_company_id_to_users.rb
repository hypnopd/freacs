class AddCompanyIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.references :company, :null=>false
    end
  end
end
