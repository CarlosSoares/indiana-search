module Api
  module V1
    # Allow search on the api
    class IndexController < BaseApiController
      before_action :set_namespace

      # POST /api/v1/:table_name/index
      def create
        render json: ElasticSearchApi.create_index(@namespace, params[:table_name], index_params)
      end

      private

      def set_namespace
        @namespace = @consumer.project.namespace
      end

      def index_params
        params[:data]
      end
    end
  end
end
