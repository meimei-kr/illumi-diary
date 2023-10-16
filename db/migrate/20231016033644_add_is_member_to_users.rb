class AddIsMemberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_member, :boolean, default: false, null: false
  end
end
