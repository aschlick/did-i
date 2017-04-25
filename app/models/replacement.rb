class Replacement < ApplicationRecord
  belongs_to :item

  after_create do
    if self.item.last_replaced_at and self.item.last_replaced_at < self.replaced_at
      self.item.update_attribute :last_replaced_at, self.replaced_at
    end
  end
end
