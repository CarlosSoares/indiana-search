class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  set_current_tenant_through_filter
  before_filter :set_company_tenancy


  def set_company_tenancy
    ActsAsTenant.current_tenant = current_user.company
  end

end
