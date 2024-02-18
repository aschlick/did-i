class NotificationJob < ApplicationRecord
  belongs_to :user
  enum :status, %w[queued completed failed cancelled]

  validates :status, presence: true

  after_create :enqueue_job, unless: ->{ jid.present? }

  def cancelled!
    Sidekiq::ScheduledSet.new.find_job(jid)&.delete
    super
  end

  def enqueue_job
    update_column(:jid, ReminderJob.perform_at(user.next_notification_time, self.id))
  end
end
