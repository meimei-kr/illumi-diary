# ログが出力されるようrake用job_typeの再定義(--silentオプションを削除)
job_type :rake, 'cd :path && :environment_variable=:environment bundle exec rake :task :output'

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# 環境変数をCronジョブ内で利用できるように、envメソッドを使用して設定
ENV.each { |k, v| env(k, v) }

# Rakeタスクの実行
every :hour do
  rake 'delete_guests:delete_expired_guests'
end