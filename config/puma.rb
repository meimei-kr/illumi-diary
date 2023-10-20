# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
# Pumaではスレッドプールを min​ および max​ 設 設定で設定して、各 Puma インスタンスが使用するスレッドの数をコントロールできる
# Heroku ではアプリケーションがすべてのリソースを所定の dyno で消費できるため、この機能は必要ないため、
# 最小が最大と等しくなるよう設定することが推奨される
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# rackup​ コマンドを使用して Puma にラックアプリを起動する方法を伝える
rackup DefaultRackup if defined?(DefaultRackup)

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV['PORT'] || 3000

# Specifies the `environment` that Puma will run in.
#
environment ENV['RACK_ENV'] || 'development'

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers Integer(ENV['WEB_CONCURRENCY'] || 2)  # dyno サイズに基づいてデフォルト値に設定される

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!

on_worker_boot do
  # Worker-specific setup for Rails 4.1 to 5.2, after 5.2 it's not needed
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
