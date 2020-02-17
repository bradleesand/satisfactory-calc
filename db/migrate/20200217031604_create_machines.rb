class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.string :name
      t.integer :input_count, null: false, default: 0

      t.timestamps
    end
  end
end
