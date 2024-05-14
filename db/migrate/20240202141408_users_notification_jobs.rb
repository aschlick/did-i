class UsersNotificationJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_jobs do |t|
      t.references :user
      t.string :jid
      t.integer :status, default: 0
      t.text :message
      t.timestamps
    end
  end
end
