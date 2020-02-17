class CreateMachineProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_processes do |t|
      t.references :recipe, foreign_key: true
      t.integer :rate, null: false, default: 1

      t.timestamps
    end
  end
end
