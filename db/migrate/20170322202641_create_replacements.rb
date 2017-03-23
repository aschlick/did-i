class CreateReplacements < ActiveRecord::Migration[5.0]
  def change
    create_table :replacements do |t|
      t.references :item
      t.timestamps
    end
  end
end
