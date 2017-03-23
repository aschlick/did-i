class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :period
      t.references :user
      t.timestamps
    end
  end
end
