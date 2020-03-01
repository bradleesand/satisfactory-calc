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

  accepts_nested_attributes_for :recipe

  delegate :output, :output_amount, :name, to: :recipe
  delegate :category, to: :output

  def per_minute(amount = output_amount)
    60 / rate * amount
  end
end
