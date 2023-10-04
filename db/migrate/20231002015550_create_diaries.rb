class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.text :content1, null: false
      t.text :content2, null: false
      t.text :content3, null: false
      t.references :user, null: false, foreign_key: true
      t.date :target_date, null: false
      t.boolean :allow_publication, default: false
      t.boolean :allow_comments, default: false

      t.timestamps
    end
  end
end
