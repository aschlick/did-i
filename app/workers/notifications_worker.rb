class NotificationsWorker
  include Sidekiq::Worker

  def perform(*args)
    Item.include(:user)
        .where('last_replaced_at + period < TIMESTAMP \'today\'')
        .group_by(&:user).each do |u|
      
    end
  end
end
