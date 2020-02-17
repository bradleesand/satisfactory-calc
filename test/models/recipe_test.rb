# == Schema Information
#
# Table name: recipes
#
#  id            :integer          not null, primary key
#  name          :string
#  output_id     :integer
#  output_amount :integer          default("1"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_recipes_on_output_id  (output_id)
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
