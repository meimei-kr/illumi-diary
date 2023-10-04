class DeleteTargetDateFromDiary < ActiveRecord::Migration[7.0]
  def change
    remove_column :diaries, :target_date, :date
  end
end
