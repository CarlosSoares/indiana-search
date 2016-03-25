# Seaches controller
class SearchesController < ApplicationController
  before_action :set_scope

  def index
    @searches = @search_scope.searches
  end

  private

  def set_scope
    @search_scope = if params.key?(:project_id)
                      current_user.projects.find(params[:project_id])
                    else
                      current_user
                    end
  end
end
