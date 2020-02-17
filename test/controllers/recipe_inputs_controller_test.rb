require 'test_helper'

class RecipeInputsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_input = recipe_inputs(:one)
  end

  test "should get index" do
    get recipe_inputs_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_input_url
    assert_response :success
  end

  test "should create recipe_input" do
    assert_difference('RecipeInput.count') do
      post recipe_inputs_url, params: { recipe_input: { amount: @recipe_input.amount, recipe_id: @recipe_input.recipe_id, resource_id: @recipe_input.resource_id } }
    end

    assert_redirected_to recipe_input_url(RecipeInput.last)
  end

  test "should show recipe_input" do
    get recipe_input_url(@recipe_input)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_input_url(@recipe_input)
    assert_response :success
  end

  test "should update recipe_input" do
    patch recipe_input_url(@recipe_input), params: { recipe_input: { amount: @recipe_input.amount, recipe_id: @recipe_input.recipe_id, resource_id: @recipe_input.resource_id } }
    assert_redirected_to recipe_input_url(@recipe_input)
  end

  test "should destroy recipe_input" do
    assert_difference('RecipeInput.count', -1) do
      delete recipe_input_url(@recipe_input)
    end

    assert_redirected_to recipe_inputs_url
  end
end
