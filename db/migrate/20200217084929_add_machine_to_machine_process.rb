class AddMachineToMachineProcess < ActiveRecord::Migration[5.2]
  def change
    add_reference :machine_processes, :machine, foreign_key: true
  end
end
