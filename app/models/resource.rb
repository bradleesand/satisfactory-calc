# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Resource < ApplicationRecord
  validates :name, presence: true

  has_many :recipes, inverse_of: :output, foreign_key: :output_id
  has_many :recipe_inputs
  has_many :used_in_recipes, through: :recipe_inputs, source: :recipe, class_name: 'Recipe'
end
