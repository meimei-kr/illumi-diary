require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IllumiDiary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g|
      g.skip_routes true      # ルーティングを追加しない
      g.helper false          # ヘルパーを追加しない
      g.test_framework false  # テストスクリプトを生成しない
    end

    # デフォルトの言語を日本語に変更
    config.i18n.default_locale = :ja

    # config/locales配下のフォルダも含めてja.ymlを参照できるように設定
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml").to_s]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
