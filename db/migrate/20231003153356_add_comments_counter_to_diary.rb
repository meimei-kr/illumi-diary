class AddCommentsCounterToDiary < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :comments_count, :integer, null: false, default: 0
  end
end
