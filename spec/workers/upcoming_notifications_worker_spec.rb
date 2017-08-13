require 'rails_helper'

describe UpcomingNotificationsWorker, type: :mailer do

  before(:all)  { @user = User.create(email: 'test@test.com', password: '123456', password_confirmation: '123456') }
  after(:all) { @user.destroy }

  it 'sends an email when a replacement is due in a day' do
    item = Item.create name: 'test item', period_type: 'Days', period_count: 1, user: @user
    item.replacements.create replaced_at: Date.today - 2.day

    expect { NotificationsWorker.new.perform }.to change { ActionMailer::Base.deliveries.count } .by 1
  end

  it 'sends only one email per user' do
    user2 = User.create(email: 'test2@test.com', password: '123456', password_confirmation: '123456')
    item = Item.create name: 'test item', period_type: 'Days', period_count: 1, user: user2
    item.replacements.create replaced_at: Date.today - 2.day

    item = Item.create name: 'test item 1', period_type: 'Days', period_count: 1, user: @user
    item.replacements.create replaced_at: Date.today - 2.day
    item = Item.create name: 'test item 2', period_type: 'Days', period_count: 1, user: @user
    item.replacements.create replaced_at: Date.today - 2.day

    expect { NotificationsWorker.new.perform }.to change { ActionMailer::Base.deliveries.count } .by 2
  end

end
