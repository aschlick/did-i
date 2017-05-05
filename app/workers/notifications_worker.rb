class NotificationsWorker
  include Sidekiq::Worker

  def perform(*args)
    Item.includes(:user).where("(last_replaced_at + period) <= (TIMESTAMP \'today\')").group_by(&:user).each do |u, items|
      UserMailer.reminder_email(u, items).deliver
    end
  end
end
