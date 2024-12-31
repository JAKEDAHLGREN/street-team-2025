class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  private

  def set_resource
    @resource = if devise_controller? && action_name.in?(%w[new create edit update])
                  User.new # For new and create actions
                elsif user_signed_in?
                  current_user # For actions where the user is signed in
                else
                  User.new # Default to a new user instance
                end
  end
end
