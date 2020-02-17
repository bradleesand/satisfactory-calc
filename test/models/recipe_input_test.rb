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

require 'test_helper'

class RecipeInputTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
