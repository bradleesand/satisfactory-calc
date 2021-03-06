class ResourcesController < AdminController
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :process_tree, :resource_tree]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
  end

  # GET /resources/new
  def new
    @resource = Resource.new(resource_params(false))
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html do
          redirect_path = if params[:commit].to_s.downcase.include? 'another'
            new_resource_path
          else
            @resource
          end
          redirect_to redirect_path, notice: 'Resource was successfully created.'
        end
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reorder
    Resource.transaction do
      resource_ids = params[:ids]
      category     = params[:category]
      Resource.update(resource_ids, resource_ids.map.with_index { |_, pos| {position: pos, **({category: category}.compact)} })
    end

    head :ok
  end

  def resource_tree
    @amount        = BigDecimal.new(params[:amount] || 1)
    @resource_tree = SatisfactoryCalculator.resource_tree(@amount, @resource).values
    render json: @resource_tree
  end

  def process_tree
    @amount       = BigDecimal.new(params[:amount] || 1)
    @process_tree = SatisfactoryCalculator.process_tree(@amount, @resource).values
    render json: @process_tree
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def resource_params(require = true)
    return {} unless require || params.key?(:resource)
    params.require(:resource).permit(:name, :position, :category)
  end
end
