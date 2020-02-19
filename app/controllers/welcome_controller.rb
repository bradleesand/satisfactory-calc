class WelcomeController < ApplicationController
  def calc
    resource = Resource.find params[:resource_id]
    amount   = params.fetch(:amount).to_i

    head       = [[amount, resource]]
    @resources = {
        resource => amount
    }

    while head.present?
      amount, resource = head.pop
      recipe           = resource.recipes.first # TODO alts?

      recipe.recipe_inputs.includes(:resource).each do |input|
        input_amount = amount * input.amount / recipe.output_amount

        head << [input_amount, input.resource]
        @resources[input.resource] = input_amount
      end
    end
  end
end
