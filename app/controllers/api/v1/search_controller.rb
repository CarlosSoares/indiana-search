module Api
  module V1
    # Allow search on the api
    class SearchController < BaseApiController
      before_action :set_namespace

      # GET /api/v1/search
      # GET /api/v1/:table_name/search/:field/:query
      def index
        @consumer.track_search(params)
        render json: ElasticSearchApi.search(@namespace, params[:table_name],
                                             params[:field], params[:query])
      end

      private

      def set_namespace
        @namespace = @consumer.project.namespace
      end
    end
  end
end
