class CreateClaps < ActiveRecord::Migration[7.0]
  def change
    create_table :claps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :diary, null: false, foreign_key: true
      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
