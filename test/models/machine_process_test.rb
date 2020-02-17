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

require 'test_helper'

class MachineProcessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
