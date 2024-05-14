 class ReminderJob < ApplicationJob
  sidekiq_options retry: 1

  def perform(notification_job_id)
    @notification_job = NotificationJob.find(notification_job_id)
    @user = @notification_job.user

    send_notifications
    send_upcoming_notifications
    mark_complete
  end

  sidekiq_retries_exhausted do |job, ex|
    tracker = NotificationJob.find_by(jid: job['id'])
    tracker.update!(
      status: 'failed',
      message: job['error_message']
    )
  end

  private

  def send_notifications
    items = @user.items.past_due
    UserMailer.reminder_email(@user, items).deliver if items.present?
  end

  def send_upcoming_notifications
    items = @user.items.due_tomorrow
    UserMailer.upcoming_reminder_email(@user, items).deliver if items.present?
  end

  def mark_complete
    @notification_job.completed!
    @notification_job.user.enqueue_new_job
  end
end
