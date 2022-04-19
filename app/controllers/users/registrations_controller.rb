# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def comfirm_email
  end

  def create
    # super
    devise_create
  end

  def devise_create
    # ここでUser.new（と同等の操作）を行う
    build_resource(sign_up_params)
    resource.build_profile
    # ここでUser.save（と同等の操作）を行う
    resource.save
    # ブロックが与えられたらresource(=User)を呼ぶ
    yield resource if block_given?
    if resource.persisted?
    # 先程のresource.saveが成功していたら
      if resource.active_for_authentication?
      # confirmable/lockableどちらかのactive_for_authentication?がtrueだったら
        # flashメッセージを設定
        set_flash_message! :notice, :signed_up
        # サインアップ操作
        sign_up(resource_name, resource)
        # リダイレクト先を指定
        respond_with resource, location: edit_account_username_path(current_user.id)
      else
        # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        # sessionを削除
        expire_data_after_sign_in!
        respond_with resource, location: comfirm_email_path
      end
    else
    # 先程のresource.saveが失敗していたら
      # passwordとpassword_confirmationをnilにする
      clean_up_passwords resource
      # validatable有効時に、パスワードの最小値を設定する
      set_minimum_password_length
      respond_with resource
    end
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
  #   redirect_to comfirm_email_path
  # end
end
