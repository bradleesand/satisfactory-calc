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

require 'test_helper'

class MachineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
