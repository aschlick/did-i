class UseInvervalType < ActiveRecord::Migration[5.0]
  def up
    remove_column :items, :period
    add_column :items, :period, :interval
  end

  def down
    remove_column :items, :period
    add_column :items, :period, :integer
  end
end
