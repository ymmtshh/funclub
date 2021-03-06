# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    # self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    # super if resource.nil? or resource.confirmed?
    super do |resource|
      sign_in(resource)
    end

  end

  # def confirm
  #   confirmation_token = params[resource_name][:confirmation_token]
  #   self.resource = resource_class.find_by_confirmation_token!(confirmation_token)
  #   if resource.update_attributes(confirm_params)
  #     self.resource = resource_class.confirm_by_token(confirmation_token)
  #     set_flash_message :notice, :confirmed
  #     sign_in(resource_name, resource)
  #     redirect_to step1_user_signups_path(current_user.id)
  #   else
  #     render :action => "show"
  #   end
  # end

  private
    def confirm_params
      params.require(resource_name).permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :confirmation_token
      )
    end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    # super(resource_name, resource)
    if current_user.profile.present?
      user_path(current_user)
    else
      step1_user_signups_path(current_user)
    end
  end
end
