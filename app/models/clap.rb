# frozen_string_literal: true

class Clap < ApplicationRecord
  belongs_to :user
  belongs_to :diary
end
