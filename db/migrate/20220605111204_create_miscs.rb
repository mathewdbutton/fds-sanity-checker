class CreateMiscs < ActiveRecord::Migration[7.0]
  def change
    create_table :miscs do |t|
      t.decimal :gvec_x
      t.decimal :gvec_y
      t.decimal :gvec_z
      t.belongs_to :validation_run, null: false, foreign_key: true
    end
  end
end
