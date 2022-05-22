class CreateSliceFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :slice_files do |t|
      t.belongs_to :validation_run, null: false, foreign_key: true
      t.string :quantity
      t.boolean :vector, default: false
      t.decimal :pbx
      t.decimal :pby
      t.decimal :pbz
      t.string :char_id
    end
  end
end
