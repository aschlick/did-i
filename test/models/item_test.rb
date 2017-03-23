require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'returns the last replaced time' do
    i = Item.create(replacements: [
      Replacement.new(created_at: Date.new('9/10/1987'))
    ])

    assert i.last_replaced == Date.new('9/10/1987')
  end
end
