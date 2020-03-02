class SatisfactoryCalculator
  class ResourceNode
    attr_accessor :amount
    attr_reader :resource, :parent_ids

    def initialize(amount, resource)
      @amount     = amount
      @resource   = resource
      @parent_ids = []
    end

    def recipe
      # TODO alts?
      resource.recipes.first
    end

    def as_json(options = nil)
      name = resource.name.pluralize(amount)

      label = "#{FormattedBigDecimal.new(amount)} #{name}"

      # super(options).merge(
      {
          id:        resource.id,
          label:     label,
          link:      "/resources/#{resource.id}",
          parentIds: parent_ids
      }
      # )
    end
  end

  def self.resource_tree(amount, resource)
    stack                  = [ResourceNode.new(amount, resource)]
    resources              = {
        resource => ResourceNode.new(amount, resource)
    }
    resources.default_proc = ->(h, k) do
      h[k] = ResourceNode.new(0, k)
    end

    until stack.empty?
      node     = stack.pop
      amount   = node.amount
      resource = node.resource
      recipe   = node.recipe

      next unless recipe

      recipe.recipe_inputs.each do |input|
        input_amount = amount * input.amount / BigDecimal.new(recipe.output_amount)

        stack << ResourceNode.new(input_amount, input.resource)
        node        = resources[input.resource]
        node.amount += input_amount
        node.parent_ids << resource.id
      end
    end

    resources
  end

  class ProcessNode
    attr_accessor :amount_per_minute
    attr_reader :process, :parents

    def initialize(amount_per_minute, process)
      @amount_per_minute = amount_per_minute
      @process           = process
      @parents           = []
    end

    def as_json(options = nil)
      machine_count = amount_per_minute / BigDecimal.new(process.per_minute)

      machine_name   = process.machine.name.pluralize(machine_count)
      machines_label = "#{FormattedBigDecimal.new(machine_count)} #{machine_name}"

      resource_name  = process.output.name.pluralize(amount_per_minute)
      resource_label = "#{FormattedBigDecimal.new(amount_per_minute)} #{resource_name}"

      label = "#{machines_label}\n(#{resource_label})"

      {
          id:        process.id,
          label:     label,
          link:      "/machine_processes/#{process.id}",
          parentIds: parents.map { |node| node.process.id }
      }
    end
  end

  def self.process_tree(amount_per_minute, resource)
    recipe                 = resource.recipes.first # TODO alts?
    process                = recipe.machine_processes.first
    stack                  = [ProcessNode.new(amount_per_minute, process)]
    processes              = {
        process => ProcessNode.new(amount_per_minute, process)
    }
    processes.default_proc = ->(h, k) do
      h[k] = ProcessNode.new(0, k)
    end

    until stack.empty?
      puts stack.to_json
      puts processes.to_json
      node              = stack.pop
      amount_per_minute = node.amount_per_minute
      process           = node.process
      recipe            = process.recipe

      recipe.recipe_inputs.each do |recipe_input|
        input_resource = recipe_input.resource
        input_recipe   = input_resource.recipes.first

        next unless input_recipe

        input_amount_per_minute = amount_per_minute * process.per_minute(recipe_input.amount) / BigDecimal.new(process.per_minute)

        input_process = input_recipe.machine_processes.first

        stack << ProcessNode.new(input_amount_per_minute, input_process)
        input_node                   = processes[input_process]
        input_node.amount_per_minute += input_amount_per_minute
        input_node.parents << node
      end
    end

    processes
  end
end