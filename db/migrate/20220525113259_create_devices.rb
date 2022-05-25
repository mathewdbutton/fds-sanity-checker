class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :orientation
      t.string :quantity
      t.string :char_id
      t.belongs_to :validation_run, null: false, foreign_key: true
    end
  end
end
