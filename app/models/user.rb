class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :claps, dependent: :nullify

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  mount_uploader :avatar_image, AvatarImageUploader
  mount_uploader :character_image, CharacterImageUploader

  attr_accessor :avatar_image_cache
  attr_accessor :character_image_cache

  # このユーザーが引数で渡されたオブジェクトの所有者であるかどうかを判定する
  def own?(object)
    id == object.user_id
  end
end
