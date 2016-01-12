class Api::V1::SearchController < BaseApiController
  before_action :set_namespace

  # GET /api/v1/search
  def index
    render json: ElasticSearch.search(@namespace, params[:table_name], params[:field], params[:query])
  end

  # GET /api/v1/search/1
  def show
  end

  # GET /api/v1/search/new
  def new

  end

  # GET /api/v1/search/1/edit
  def edit
  end

  # POST /api/v1/search
  # POST /api/v1/search.json
  def create
    body = params[:body]

    method = body.is_a?(Array) ? "create_multiple_index" : "create_index"

    render json: ElasticSearch.send(method, @namespace, params[:table_name], body)
  end

  # PATCH/PUT /api/v1/search/1
  # PATCH/PUT /api/v1/search/1.json
  def update
    if @api_v1_index.update(api_v1_index_params)
      render :show, status: :ok, location: @api_v1_index
    else
      render json: @api_v1_index.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/search/1
  # DELETE /api/v1/search/1.json
  def destroy
    @api_v1_index.destroy
    head :no_content
  end

  private

  def set_namespace
    @namespace = Project.first.namespace
  end

end
