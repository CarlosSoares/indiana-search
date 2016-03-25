# Consumer Controller
class ConsumersController < ApplicationController
  before_action :set_project
  before_action :set_consumer, only: [:show, :edit, :update, :destroy]

  def index
    @consumers = @project.consumers
  end

  def show
  end

  def new
    @consumer = @project.consumers.new
  end

  def edit
  end

  def create
    @consumer = @project.consumers.build(consumer_params)

    if @consumer.save
      redirect_to project_consumers_path(@project), notice: 'Consumer was successfully created.'
    else
      render :new
    end
  end

  def update
    if @consumer.update(consumer_params)
      redirect_to project_consumers_path(@project, @consumer), notice: 'Consumer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @consumer.destroy
    redirect_to project_consumers_path(@project), notice: 'Consumer was successfully destroyed.'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_consumer
    @consumer = current_user.consumers.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def consumer_params
    params.require(:consumer).permit(:name)
  end
end
