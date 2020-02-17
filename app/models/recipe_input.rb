# == Schema Information
#
# Table name: recipe_inputs
#
#  id          :integer          not null, primary key
#  recipe_id   :integer
#  resource_id :integer
#  amount      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipe_inputs_on_recipe_id    (recipe_id)
#  index_recipe_inputs_on_resource_id  (resource_id)
#

class RecipeInput < ApplicationRecord
  belongs_to :recipe
  belongs_to :resource

  validates :amount, numericality: {greater_than: 0}

  delegate :name, to: :resource
end
