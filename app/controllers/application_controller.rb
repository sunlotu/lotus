class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in){ |u| u.permit(*User::ACCESSABLE_ATTRS) }
    devise_parameter_sanitizer.permit(:sign_up){ |u| u.permit(*User::ACCESSABLE_ATTRS) }
    devise_parameter_sanitizer.permit :account_update, keys: User::ACCESSABLE_ATTRS
  end

  def after_sign_in
    if current_user.admin?
      redirect_to admin_posts_path
    else
      redirect_to post_path
    end
  end

end
