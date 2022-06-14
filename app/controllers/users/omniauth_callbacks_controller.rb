# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def twitter
    callback_from :twitter
  end

  def google_oauth2
    callback_from :google
  end

  def failure
    redirect_to root_path and return
  end

  private
  def callback_from(provider)
    provider = provider.to_s
    info = User.from_omniauth(request.env["omniauth.auth"])
    @user = info[:user]
    if @user.persisted? 
      # sign_in_and_redirect @user, event: :authentication
      if @user.profile.present?
        sign_in(@user)
        redirect_to root_path
      else
        sign_in(@user)
        redirect_to step1_user_signups_path(current_user)
      end
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_path(current_user)
    end
  end

end