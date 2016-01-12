class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  set_current_tenant_through_filter

  def set_company_tenancy
    ActsAsTenant.current_tenant = current_user.company
  end

end
