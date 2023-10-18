require 'rails_helper'
require 'rake'

RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.load_tasks # 全てのタスクを読み込む
  end

  config.before do
    Rake.application.tasks.each(&:reenable) # 全てのタスクをリセットする
  end
end
