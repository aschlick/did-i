require 'rails_helper'

RSpec.describe Replacement do

  let(:user) { User.create(email: 'test@test.com', password: '123456', password_confirmation: '123456') }

  it 'sets item replaced at when created' do
    i = Item.create name: 'test item', period_type: 'years', period_count: 2, user: user

    i.replacements.create replaced_at: Date.yesterday

    i.reload
    expect(i.last_replaced_at).to eq(Date.yesterday.to_datetime)
  end

  it 'it only updates replaced at when newer date' do
    i = Item.create name: 'test item', last_replaced_at: Date.today.to_datetime, period_type: 'years', period_count: 2, user: user

    i.replacements.create replaced_at: Date.yesterday

    i.reload
    expect(i.last_replaced_at).to eq(Date.today.to_datetime)
  end
end
