class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.text :body
      t.references :auction, :null => false
      t.timestamps
    end
  end
end
