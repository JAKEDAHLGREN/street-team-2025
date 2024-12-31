# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
    @resource = User.new
  end

  # POST /resource/sign_in
  def create
    super do |resource|
      @resource = resource
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do
      redirect_to new_user_session_path and return # Redirect directly to the sign-in page
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
