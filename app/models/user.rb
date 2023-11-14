# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :claps, dependent: :nullify
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, confirmation: true, length: { minimum: 8 }, if: :should_validate_password?
  validates :password_confirmation, presence: true, if: :should_validate_password?
  validates :reset_password_token, uniqueness: true, allow_nil: true

  mount_uploader :avatar_image, AvatarImageUploader
  mount_uploader :character_image, CharacterImageUploader

  attr_accessor :avatar_image_cache, :character_image_cache, :updating_password

  scope :expired_guests, -> { where(is_member: false).where('created_at < ?', 1.day.ago) }

  enum rank: { general: 0, bronze: 1, silver: 2, gold: 3 }

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
    (Time.zone.today - 99..Time.zone.today).reverse_each do |date|
      start_of_day = date.beginning_of_day
      end_of_day = date.end_of_day
      diaries_until_today = diaries.where(created_at: start_of_day..end_of_day)
      break if diaries_until_today.blank?

      days += 1
    end
    days
  end

  def logged_in_with_oauth?
    authentications.present?
  end
end
