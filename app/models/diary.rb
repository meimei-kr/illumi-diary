# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :claps, dependent: :destroy

  validates :content1, presence: true, length: { maximum: 140 }
  validates :content2, presence: true, length: { maximum: 140 }
  validates :content3, presence: true, length: { maximum: 140 }

  def count_all_claps
    claps.sum(:count)
  end

  def count_user_claps(user)
    claps.where(user_id: user.id).sum(:count)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
