class RemoveClapsCountFromDiaries < ActiveRecord::Migration[7.0]
  def change
    remove_column :diaries, :claps_count, :integer, null: false, default: 0
  end
end
