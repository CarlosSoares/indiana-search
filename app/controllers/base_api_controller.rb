class BaseApiController < ActionController::Base
  before_filter :authenticate_user_from_token!

  protected

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    token = request.authorization.to_s.split(' ')[1] rescue ""
    @consumer  = token.present? && Consumer.find_by_token(token)

    unless @consumer
      render_unauthorized
    end
  end
end
