# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#  category   :integer
#

class Resource < ApplicationRecord
  default_scope { order(:category, :position) }

  CATEGORIES = {
      ores:             'ores',
      ingots:           'ingots',
      standard_parts:   'standard parts',
      electronics:      'electronics',
      minerals:         'minerals',
      biomass:          'biomass',
      industrial_parts: 'industrial parts',
      consumed:         'consumed',
      power_shard:      'power shards',
      communications:   'communications',
      space_elevator:   'space elevator',
  }.freeze

  enum category: {
      ores:             0,
      ingots:           10,
      standard_parts:   20,
      electronics:      30,
      minerals:         40,
      biomass:          50,
      industrial_parts: 60,
      consumed:         70,
      power_shard:      80,
      communications:   90,
      space_elevator:   100,
  }

  validates :name, presence: true

  has_many :recipes, inverse_of: :output, foreign_key: :output_id
  has_many :recipe_inputs
  has_many :used_in_recipes, through: :recipe_inputs, source: :recipe, class_name: 'Recipe'
end
