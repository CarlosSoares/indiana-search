class ConsumersController < ApplicationController
  before_action :set_project
  before_action :set_consumer, only: [:show, :edit, :update, :destroy]

  # GET /consumers
  # GET /consumers.json
  def index
    @consumers = @project.consumers
  end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
  end

  # GET /consumers/new
  def new
    @consumer = @project.consumers.new
  end

  # GET /consumers/1/edit
  def edit
  end

  # POST /consumers
  # POST /consumers.json
  def create
    @consumer =  @project.consumers.build(consumer_params)

    respond_to do |format|
      if @consumer.save
        format.html { redirect_to project_consumers_path(@project), notice: 'Consumer was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumers/1
  # PATCH/PUT /consumers/1.json
  def update
    respond_to do |format|
      if @consumer.update(consumer_params)
        format.html { redirect_to @consumer, notice: 'Consumer was successfully updated.' }
        format.json { render :show, status: :ok, location: @consumer }
      else
        format.html { render :edit }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumers/1
  # DELETE /consumers/1.json
  def destroy
    @consumer.destroy
    respond_to do |format|
      format.html { redirect_to consumers_url, notice: 'Consumer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = current_user.projects.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:name)
    end
end
