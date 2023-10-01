class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name,             null: false
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :avatar_image
      t.string :character_image

      t.timestamps                null: false
    end
  end
end