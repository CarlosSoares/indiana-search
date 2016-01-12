class Api::V1::IndicesController < BaseApiController
  before_action :set_api_v1_index, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/indices
  # GET /api/v1/indices.json
  def index
    render json: {}
  end

  # GET /api/v1/indices/1
  # GET /api/v1/indices/1.json
  def show
  end

  # GET /api/v1/indices/new
  def new
    @api_v1_index = Api::V1::Index.new
  end

  # GET /api/v1/indices/1/edit
  def edit
  end

  # POST /api/v1/indices
  # POST /api/v1/indices.json
  def create
    @api_v1_index = Api::V1::Index.new(api_v1_index_params)

    respond_to do |format|
      if @api_v1_index.save
        format.html { redirect_to @api_v1_index, notice: 'Index was successfully created.' }
        format.json { render :show, status: :created, location: @api_v1_index }
      else
        format.html { render :new }
        format.json { render json: @api_v1_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/indices/1
  # PATCH/PUT /api/v1/indices/1.json
  def update
    respond_to do |format|
      if @api_v1_index.update(api_v1_index_params)
        format.html { redirect_to @api_v1_index, notice: 'Index was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_v1_index }
      else
        format.html { render :edit }
        format.json { render json: @api_v1_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/indices/1
  # DELETE /api/v1/indices/1.json
  def destroy
    @api_v1_index.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_indices_url, notice: 'Index was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_index
      @api_v1_index = Api::V1::Index.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_index_params
      params[:api_v1_index]
    end
end
