class CreateHeads < ActiveRecord::Migration[7.0]
  def change
    create_table :heads do |t|
      t.string :chid
      t.string :title
      t.belongs_to :validation_run, null: false, foreign_key: true
    end
  end
end
