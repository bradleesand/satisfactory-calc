class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.references :output, foreign_key: {to_table: :resources}
      t.integer :output_amount, null: false, default: 1

      t.timestamps
    end
  end
end
