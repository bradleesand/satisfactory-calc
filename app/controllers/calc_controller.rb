class CalcController < ApplicationController
  def calc
    return render unless params.key?(:resource) && params.key?(:amount)

    @amount   = params.fetch(:amount).to_i
    @resource = Resource.find params[:resource]

    head                    = [[@amount, @resource]]
    @resources              = {
        @resource => {
            id:     @resource.id,
            amount: @amount
        }
    }
    @resources.default_proc = ->(h, k) do
      h[k] = {
          id:        k.id,
          amount:    0,
          parentIds: []
      }
    end

    while head.present?
      amount, resource = head.pop
      recipe           = resource.recipes.first # TODO alts?

      next unless recipe

      recipe.recipe_inputs.includes(:resource).each do |input|
        input_amount = amount * input.amount / BigDecimal.new(recipe.output_amount)

        head << [input_amount, input.resource]
        node          = @resources[input.resource]
        node[:amount] += input_amount
        node[:parentIds] << resource.id
      end
    end

    @dag_data = @resources.map do |resource, node|
      amount = node[:amount]
      name   = resource.name.pluralize(amount)

      amount = if amount == amount.to_i
        amount.to_i
      else
        amount.truncate(2)
      end

      node.merge(label: "#{amount} #{name}")
    end
  end
end
