# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary, counter_cache: true

  validates :content, presence: true, length: { maximum: 140 }
end
