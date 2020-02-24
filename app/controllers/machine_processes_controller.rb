class MachineProcessesController < AdminController
  before_action :set_machine_process, only: [:show, :edit, :update, :destroy]

  # GET /machine_processes
  # GET /machine_processes.json
  def index
    @machine_processes = MachineProcess.joins(recipe: :output).merge(Resource.all)
  end

  # GET /machine_processes/1
  # GET /machine_processes/1.json
  def show
  end

  # GET /machine_processes/new
  def new
    @machine_process = MachineProcess.new(machine_process_params(false))
  end

  # GET /machine_processes/1/edit
  def edit
  end

  # POST /machine_processes
  # POST /machine_processes.json
  def create
    @machine_process = MachineProcess.new(machine_process_params)

    respond_to do |format|
      if @machine_process.save
        format.html { redirect_to @machine_process, notice: 'Machine process was successfully created.' }
        format.json { render :show, status: :created, location: @machine_process }
      else
        format.html { render :new }
        format.json { render json: @machine_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machine_processes/1
  # PATCH/PUT /machine_processes/1.json
  def update
    respond_to do |format|
      if @machine_process.update(machine_process_params)
        format.html { redirect_to @machine_process, notice: 'Machine process was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine_process }
      else
        format.html { render :edit }
        format.json { render json: @machine_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_processes/1
  # DELETE /machine_processes/1.json
  def destroy
    @machine_process.destroy
    respond_to do |format|
      format.html { redirect_to machine_processes_url, notice: 'Machine process was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recipe_form
    @recipe = if params.key? :recipe_id
      Recipe.find_by id: params[:recipe_id]
    else
      Recipe.new do |r|
        params[:input_count].to_i.times { r.recipe_inputs.build } if params.key? :input_count
      end
    end

    render layout: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_machine_process
    @machine_process = MachineProcess.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def machine_process_params(require = true)
    return {} unless require || params.key?(:machine_process)
    params.require(:machine_process).permit(:recipe_id, :rate, :machine_id,
                                            recipe_attributes: [:id, :name, :output_id, :output_amount,
                                                                recipe_inputs_attributes: [:id, :resource_id, :amount]])
  end
end
