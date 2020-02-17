json.extract! recipe_input, :id, :recipe_id, :resource_id, :amount, :created_at, :updated_at
json.url recipe_input_url(recipe_input, format: :json)
