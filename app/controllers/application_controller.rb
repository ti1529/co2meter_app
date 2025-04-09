class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

rescue_from CanCan::AccessDenied do |_exception|
  redirect_to root_path, alert: t("common.alert")
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :admin, :company_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :admin, :company_id ])
  end

  private
  def current_user?(user)
    user == current_user
  end

end
