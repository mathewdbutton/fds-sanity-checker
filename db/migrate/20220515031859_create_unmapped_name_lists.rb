class CreateUnmappedNameLists < ActiveRecord::Migration[7.0]
  def change
    create_table :unmapped_name_lists do |t|
      t.string :line
      t.belongs_to :validation_run, null: false, foreign_key: true
    end
  end
end
