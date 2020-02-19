class AddCategoryToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :category, :integer
  end
end
