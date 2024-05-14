class UserPreference < ApplicationRecord
  belongs_to :user

  after_save :reset_user_notifications_job

  def reset_user_notifications_job
    if saved_change_to_notification_time?
      user.ensure_notification_job
    end
  end
end
