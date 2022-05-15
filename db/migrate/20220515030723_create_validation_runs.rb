class CreateValidationRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :validation_runs do |t|
      t.string :run_id
      t.timestamps
    end

    add_reference(:vents, :validation_runs)
    add_reference(:surfaces, :validation_runs)
    add_index(:surfaces, [:char_id, :validation_run_id], unique: true)
  end
end
