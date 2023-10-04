class AddClapsCountToDiary < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :claps_count, :integer, null: false, default: 0
  end
end
