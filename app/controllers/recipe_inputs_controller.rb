class RecipeInputsController < AdminController
  before_action :set_recipe_input, only: [:show, :edit, :update, :destroy]

  # GET /recipe_inputs
  # GET /recipe_inputs.json
  def index
    @recipe_inputs = RecipeInput.all
  end

  # GET /recipe_inputs/1
  # GET /recipe_inputs/1.json
  def show
  end

  # GET /recipe_inputs/new
  def new
    @recipe_input = RecipeInput.new
  end

  # GET /recipe_inputs/1/edit
  def edit
  end

  # POST /recipe_inputs
  # POST /recipe_inputs.json
  def create
    @recipe_input = RecipeInput.new(recipe_input_params)

    respond_to do |format|
      if @recipe_input.save
        format.html { redirect_to @recipe_input, notice: 'Recipe input was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_input }
      else
        format.html { render :new }
        format.json { render json: @recipe_input.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_inputs/1
  # PATCH/PUT /recipe_inputs/1.json
  def update
    respond_to do |format|
      if @recipe_input.update(recipe_input_params)
        format.html { redirect_to @recipe_input, notice: 'Recipe input was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_input }
      else
        format.html { render :edit }
        format.json { render json: @recipe_input.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_inputs/1
  # DELETE /recipe_inputs/1.json
  def destroy
    @recipe_input.destroy
    respond_to do |format|
      format.html { redirect_to recipe_inputs_url, notice: 'Recipe input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_input
      @recipe_input = RecipeInput.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_input_params
      params.require(:recipe_input).permit(:recipe_id, :resource_id, :amount)
    end
end
