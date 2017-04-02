class LetsNotUseCreatedDate < ActiveRecord::Migration[5.0]
  def change
    add_column :replacements, :replaced_at, :datetime
  end
end
