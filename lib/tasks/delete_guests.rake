# frozen_string_literal: true

namespace :delete_guests do
  desc '作成から1日超過したゲストユーザーを削除する'
  task delete_expired_guests: :environment do
    User.expired_guests.destroy_all
  end
end
