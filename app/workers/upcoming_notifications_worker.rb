class UpcomingNotificationsWorker
  # include Sidekiq::Worker

  def perform(*args)
    Item.includes(:user)
      .where("date_trunc('day', last_replaced_at + period) = (TIMESTAMP \'tomorrow\')")
      .group_by(&:user)
      .each do |u, items|
        UserMailer.upcoming_reminder_email(u, items).deliver
    end
  end
end
