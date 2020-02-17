class CreateRecipeInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_inputs do |t|
      t.references :recipe, foreign_key: true
      t.references :resource, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
