class UsersNotificationTime < ActiveRecord::Migration[7.0]
  def change
    create_table :user_preferences do |t|
      t.references :user
      t.column :notification_time, :time, default: '00:00:00'
      t.timestamps
    end
  end
end
