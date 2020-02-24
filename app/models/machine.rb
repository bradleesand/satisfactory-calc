# == Schema Information
#
# Table name: machines
#
#  id          :integer          not null, primary key
#  name        :string
#  input_count :integer          default("0"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Machine < ApplicationRecord
  has_many :machine_processes

  validates :name, presence: true
  validates :input_count, numericality: {greater_than_or_equal_to: 0}

  def options_for_select
    [name, id, data: {inputs: input_count}]
  end
end
