class CalcController < ApplicationController
  def calc
    return render unless params.key?(:resource) && params.key?(:amount)

    @amount = BigDecimal.new(params.fetch(:amount))
    @resource = Resource.find params[:resource]

    # @resource_tree = SatisfactoryCalculator.resource_tree(@amount, @resource).values
    @process_tree = SatisfactoryCalculator.process_tree(@amount, @resource).values
  end
end
