class BaseApiController < ApplicationController
  skip_before_action :authenticate_user!

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
    token = request.authorization.split(' ')[1]
    user_token = token.present?
    user       = user_token && User.find_by_authentication_token(token)

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
