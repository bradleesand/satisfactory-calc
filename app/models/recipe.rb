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

class Recipe < ApplicationRecord
  belongs_to :output, class_name: 'Resource', foreign_key: :output_id

  has_many :machine_processes
  has_many :recipe_inputs, dependent: :destroy
  has_many :inputs, through: :recipe_inputs, source: :resource, class_name: 'Resource'

  accepts_nested_attributes_for :recipe_inputs, allow_destroy: true

  validates :name, presence: true
  validates :output, presence: true
  validates :output_amount, numericality: {greater_than: 0}

  def options_for_select
    [name, id, data: {inputs: recipe_inputs.size}]
  end
end
