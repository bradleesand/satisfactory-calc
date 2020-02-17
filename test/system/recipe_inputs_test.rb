require "application_system_test_case"

class RecipeInputsTest < ApplicationSystemTestCase
  setup do
    @recipe_input = recipe_inputs(:one)
  end

  test "visiting the index" do
    visit recipe_inputs_url
    assert_selector "h1", text: "Recipe Inputs"
  end

  test "creating a Recipe input" do
    visit recipe_inputs_url
    click_on "New Recipe Input"

    fill_in "Amount", with: @recipe_input.amount
    fill_in "Recipe", with: @recipe_input.recipe_id
    fill_in "Resource", with: @recipe_input.resource_id
    click_on "Create Recipe input"

    assert_text "Recipe input was successfully created"
    click_on "Back"
  end

  test "updating a Recipe input" do
    visit recipe_inputs_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @recipe_input.amount
    fill_in "Recipe", with: @recipe_input.recipe_id
    fill_in "Resource", with: @recipe_input.resource_id
    click_on "Update Recipe input"

    assert_text "Recipe input was successfully updated"
    click_on "Back"
  end

  test "destroying a Recipe input" do
    visit recipe_inputs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recipe input was successfully destroyed"
  end
end
