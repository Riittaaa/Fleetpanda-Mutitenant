# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create, :new]

  # GET /resource/sign_in
  def new
    @organizations = Organization.all
  super
  end

  # POST /resource/sign_in
  def create
    @organizations = Organization.all
    debugger
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:organization_id])
  end
end
