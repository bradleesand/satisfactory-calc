require 'test_helper'

class MachineProcessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @machine_process = machine_processes(:one)
  end

  test "should get index" do
    get machine_processes_url
    assert_response :success
  end

  test "should get new" do
    get new_machine_process_url
    assert_response :success
  end

  test "should create machine_process" do
    assert_difference('MachineProcess.count') do
      post machine_processes_url, params: { machine_process: { rate: @machine_process.rate, recipe_id: @machine_process.recipe_id } }
    end

    assert_redirected_to machine_process_url(MachineProcess.last)
  end

  test "should show machine_process" do
    get machine_process_url(@machine_process)
    assert_response :success
  end

  test "should get edit" do
    get edit_machine_process_url(@machine_process)
    assert_response :success
  end

  test "should update machine_process" do
    patch machine_process_url(@machine_process), params: { machine_process: { rate: @machine_process.rate, recipe_id: @machine_process.recipe_id } }
    assert_redirected_to machine_process_url(@machine_process)
  end

  test "should destroy machine_process" do
    assert_difference('MachineProcess.count', -1) do
      delete machine_process_url(@machine_process)
    end

    assert_redirected_to machine_processes_url
  end
end
