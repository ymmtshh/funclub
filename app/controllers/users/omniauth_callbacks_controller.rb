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
    callback_from_twitter
  end

  def google_oauth2
    callback_from_google
  end

  def failure
    redirect_to root_path
  end

  private
  def callback_from_twitter
    provider = provider.to_s
    @user = User.find_for_oauth_twitter(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.twitter_data"] = request.env['omniauth.auth'].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def callback_from_google
    provider = provider.to_s
    @user = User.find_for_oauth_google(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env['omniauth.auth'].except("extra")
      redirect_to new_user_registration_url
    end
  end
end