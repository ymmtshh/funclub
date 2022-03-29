class OmniauthCallbacksController < ApplicationController

  def twitter
    callback_from :twitter
  end

  def failure
    @notice = "failure"
    redirect_to events_path, notice: 'failure'
  end


  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      print("persisted true")
      @notice = "persisted true"
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      print("persisted false")
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      @notice = "user is not persisted."
      redirect_to root_path, notice: 'user is not persisted.'
    end
  end
end
