class BaseApiController < ActionController::Base
  protect_from_forgery with: :null_session
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
    user  = token.present? && User.find_by_authentication_token(token)
    user = User.first
    #project = Project.first

    #Rails.logger.info "=====#{user.inspect}"
    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    else
      render_unauthorized
    end
  end
end
