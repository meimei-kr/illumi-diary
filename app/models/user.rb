class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
