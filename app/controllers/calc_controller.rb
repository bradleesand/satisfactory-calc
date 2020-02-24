class CalcController < ApplicationController
  def calc
    return render unless params.key?(:resource) && params.key?(:amount)

    @amount   = params.fetch(:amount).to_i
    @resource = Resource.find params[:resource]

    head       = [[@amount, @resource]]
    @resources = {
        @resource => @amount
    }
    @resources.default = 0

    while head.present?
      amount, @resource = head.pop
      recipe            = @resource.recipes.first # TODO alts?

      next unless recipe

      recipe.recipe_inputs.includes(:resource).each do |input|
        input_amount = amount * input.amount / recipe.output_amount

        head << [input_amount, input.resource]
        @resources[input.resource] = @resources.delete(input.resource).to_i + input_amount
      end
    end
  end
end
