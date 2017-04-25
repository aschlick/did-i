class ReplacedAtCache < ActiveRecord::Migration[5.0]
  def up
    add_column :items, :last_replaced_at, :datetime

    Item.includes(:replacements).order('replacements.replaced_at desc').each do |i|
      if i.replacements.length > 0
        i.update_attribute(:last_replaced_at, i.replacements.first.replaced_at)
      end
    end
  end

  def down
    remove_colummn :items, :last_replaced_at
  end
end
