require "application_system_test_case"

class MachineProcessesTest < ApplicationSystemTestCase
  setup do
    @machine_process = machine_processes(:one)
  end

  test "visiting the index" do
    visit machine_processes_url
    assert_selector "h1", text: "Machine Processes"
  end

  test "creating a Machine process" do
    visit machine_processes_url
    click_on "New Machine Process"

    fill_in "Rate", with: @machine_process.rate
    fill_in "Recipe", with: @machine_process.recipe_id
    click_on "Create Machine process"

    assert_text "Machine process was successfully created"
    click_on "Back"
  end

  test "updating a Machine process" do
    visit machine_processes_url
    click_on "Edit", match: :first

    fill_in "Rate", with: @machine_process.rate
    fill_in "Recipe", with: @machine_process.recipe_id
    click_on "Update Machine process"

    assert_text "Machine process was successfully updated"
    click_on "Back"
  end

  test "destroying a Machine process" do
    visit machine_processes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Machine process was successfully destroyed"
  end
end
