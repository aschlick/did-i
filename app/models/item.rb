class Item < ApplicationRecord
  has_many :replacements
  belongs_to :user

  attr_accessor :period_count, :period_type

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :period_count, presence: true
  validates :period_type, presence: true

  before_save do
    assign_period_from_strings
  end

  after_find do |item|
    if item.period and item.period.class == String
      item.period_count, item.period_type = item.period.split ' '

      item.period_count = item.period_count.to_i
      item.period_type = item.period_type.titleize

      item.assign_period_from_strings
    end
  end

  def assign_period_from_strings
    if self.period_count and self.period_type
      self.period = period_count.method(period_type.downcase).call().iso8601()
    end
  end

  def duration
    ActiveSupport::Duration.parse(self.period)
  end
end
