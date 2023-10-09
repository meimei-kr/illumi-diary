class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :claps, dependent: :nullify

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, length: { minimum: 8 }, if: :should_validate_password?
  validates :password_confirmation, presence: true, if: :should_validate_password?

  mount_uploader :avatar_image, AvatarImageUploader
  mount_uploader :character_image, CharacterImageUploader

  attr_accessor :avatar_image_cache
  attr_accessor :character_image_cache
  attr_accessor :updating_password

  # パスワードのバリデーションを実行するか判定する
  def should_validate_password?
    new_record? || updating_password
  end

  # このユーザーが引数で渡されたオブジェクトの所有者であるかどうかを判定する
  def own?(object)
    id == object.user_id
  end

  # 当日含めて連続で日記を書いている日数を返す
  def continuous_writing_days
    days = 0
    (Time.zone.today - 99 .. Time.zone.today).reverse_each do |date|
      start_of_day = date.beginning_of_day
      end_of_day = date.end_of_day
      diaries_of_today = self.diaries.where(created_at: start_of_day..end_of_day)
      if diaries_of_today.present?
        days += 1
      else
        break
      end
    end
    days
  end
end
