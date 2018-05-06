require 'rails_helper'

describe Item do

  it 'converts mons to Months' do
    item = Item.new
    item.period = '2 mons'

    item.run_callbacks(:find)

    expect(item.period_type).to eq 'Months'
  end
end
