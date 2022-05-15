class CreateVents < ActiveRecord::Migration[7.0]
  def change
    create_table :vents do |t|
      t.belongs_to :surface, type: :string
    end
  end
end
