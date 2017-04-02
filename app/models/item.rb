class Item < ApplicationRecord
  has_many :replacements

  def last_replaced
    replacements.order(created_at: :desc).first.try(:created_at)
  end
end
