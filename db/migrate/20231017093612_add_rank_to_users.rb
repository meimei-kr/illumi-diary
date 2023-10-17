class AddRankToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rank, :integer, default: 0, null: false
  end
end
