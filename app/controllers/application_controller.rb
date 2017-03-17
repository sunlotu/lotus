class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_active_menu
    @current = ["/#{controller_name}"]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in){ |u| u.permit(*User::ACCESSABLE_ATTRS) }
    devise_parameter_sanitizer.permit(:sign_up){ |u| u.permit(*User::ACCESSABLE_ATTRS) }
  end

end
