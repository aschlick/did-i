require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe ReminderJob, type: :job do
  let(:user) { User.create(email: 'test@test.com', password: '123456', password_confirmation: '123456') }
  let!(:notification_job) { user.notification_jobs.create }

  it 'sends an email when a replacement is due in a day' do
    item = Item.create(
      name: 'test item',
      period_type: 'Weeks',
      period_count: 1,
      user: user)
    item.replacements.create replaced_at: DateTime.now - 1.week + 1.day

    expect { described_class.new.perform(notification_job.id) }.to change { ActionMailer::Base.deliveries.count } .by 1
  end

  it 'sends an email when a replacement is due' do
    item = Item.create name: 'test item', period_type: 'Days', period_count: 1, user: user
    item.replacements.create replaced_at: Date.today - 1.day

    expect { described_class.new.perform(notification_job.id) }.to change { ActionMailer::Base.deliveries.count } .by 1
  end

  it 'queues up the next job' do
    expect { described_class.new.perform(notification_job.id) }.to change { described_class.jobs.size } .by 1
  end
end
