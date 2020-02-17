# == Schema Information
#
# Table name: machine_processes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer
#  rate       :integer          default("1"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  machine_id :integer
#
# Indexes
#
#  index_machine_processes_on_machine_id  (machine_id)
#  index_machine_processes_on_recipe_id   (recipe_id)
#

class MachineProcess < ApplicationRecord
  belongs_to :recipe
  belongs_to :machine

  validates :recipe, presence: true
  validates :machine, presence: true

  def per_minute
    60 / rate * recipe.output_amount
  end
end
