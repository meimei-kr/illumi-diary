require 'rake_helper'

describe 'delete_guests:delete_expired_guests' do
  subject(:task) { Rake.application['delete_guests:delete_expired_guests'] }
  before do
    create(:user, :guest, created_at: 1.day.ago)
  end
  it 'deletes_expired_guests' do
    expect { task.invoke }.to change{ User.all.size }.by(-1)
  end
end