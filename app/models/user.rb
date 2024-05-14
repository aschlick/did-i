class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable, :lockable

  has_many :items, dependent: :destroy

  has_many :notification_jobs

  has_one :user_preference

  def admin?
    email == 'alexander@schlickster.us' || Rails.env.development?
  end

  def jid
    notification_jobs.queued.order(created_at: :desc).first&.jid
  end

  def next_notification_time
    time = (user_preference&.notification_time || Time.new)
    # using DateTime.now to keep it in this timezone because Sidekiq uses Time.now for comparison
    (DateTime.now + 1.day).change(hour: time.hour, min: time.min, sec: time.sec)
  end

  def ensure_notification_job
    if jid
      notification_jobs.queued.each(&:cancelled!)
    end
    enqueue_new_job
  end

  def enqueue_new_job
    notification_jobs.create!
  end

  def self.ensure_all_enqueued
    User.all.each(&:ensure_notification_job)
  end
end
