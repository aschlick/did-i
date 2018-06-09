class Item < ApplicationRecord
  has_many :replacements, dependent: :destroy
  belongs_to :user

  attr_accessor :period_count, :period_type

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :period_count, presence: true
  validates :period_type, presence: true

  before_save do
    assign_period_from_strings unless destroyed?
  end

  after_find do |item|
    if !destroyed? and item.period and item.period.class == String
      item.period_count, item.period_type = item.period.split ' '

      item.period_count = item.period_count.to_i
      if item.period_type
        item.period_type = 'months' if item.period_type == 'mon' || item.period_type == 'mons'

        item.period_type = item.period_type.titleize
      end

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
