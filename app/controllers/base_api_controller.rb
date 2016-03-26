# Base Api controller
class BaseApiController < ActionController::Base
  before_action :authenticate_user_from_token!

  protected

  def render_unauthorized
    headers['WWW-Authenticate'] = 'Bearer realm="Application"'
    render json: { message: 'Bad credentials' }, status: 401
  end

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    token = request.authorization.to_s.gsub("Bearer ", '')
    @consumer = token.present? && Consumer.find_by_token(token)

    render_unauthorized unless @consumer
  end
end
