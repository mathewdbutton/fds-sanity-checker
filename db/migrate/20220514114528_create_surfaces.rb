class CreateSurfaces < ActiveRecord::Migration[7.0]
  def change
    create_table :surfaces do |t|
      t.string :char_id
      t.decimal :volume_flow
    end
  end
end
