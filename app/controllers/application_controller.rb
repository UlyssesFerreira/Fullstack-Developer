class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You do not have permission to access this page."
      redirect_to profile_user_path 
    end
  end

  def after_sign_in_path_for(user)
    if user.admin?
      admin_dashboard_path
    else
      profile_user_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :avatar_image, :avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end
end
