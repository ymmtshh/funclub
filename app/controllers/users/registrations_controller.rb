# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    super
    resource.build_profile
    resource.profile.name = resource.username
    resource.save
  end
  
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :band])
  end

  def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :band])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   # super(resource)
  #   if @user.role == "band"
  #     redirect_to posts_user_path(@user)
  #   elsif @user.role == "fan"
  #     redirect_to edit_profile_path(@user)
  #   else
  #     redirect_to new_user_registration_path
  #   end
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   if @user.user_type == "band"
  #     redirect_to posts_user_path
  #   elsif @user.user_type == "fan"
  #     redirect_to edit_profile_path
  #   else
  #     redirect_to new_user_registration_path
  #   end
  # end
end
