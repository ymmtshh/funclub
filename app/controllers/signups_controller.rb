class SignupsController < ApplicationController
  before_action :save_to_session, only: :step2

  def step1
    @user = User.find(current_user.id)
    @profile = Profile.new # 新規インスタンス作成
  end

  def step2
    @user = User.find(current_user.id)
    @profile = Profile.new # 新規インスタンス作成
    @profile.build_social_profile
  end

  def save_to_session
    # step1で入力した値をsessionに保存
    session[:name] = profile_params[:name]
    session[:introduction] = profile_params[:introduction]
    session[:prefecture_id] = profile_params[:prefecture_id]
    session[:web] = profile_params[:web]
    session[:avatar] = profile_params[:avatar]
    @profile = Profile.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      introduction: session[:introduction],
      prefecture_id: session[:prefecture_id],
      web: profile_params[:web],  # step2で入力した値をインスタンスに渡す
      avatar: profile_params[:avatar],  # step2で入力した値をインスタンスに渡す
      avatar_cache: profile_params[:avatar_cache]  # step2で入力した値をインスタンスに渡す
    )
    # インスタンスにバリデーションをかけ、通らなければ1step目のページを再度表示する
    # render '/signup/step1' unless @profile.valid?
  end

  def create
    @user = User.find(current_user.id)
    @profile = Profile.new(
      user_id: current_user.id,
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      introduction: session[:introduction],
      prefecture_id: session[:prefecture_id],
      web: profile_params[:web],  # step2で入力した値をインスタンスに渡す
      avatar: profile_params[:avatar],  # step2で入力した値をインスタンスに渡す
      avatar_cache: profile_params[:avatar_cache]  # step2で入力した値をインスタンスに渡す
    )
    @profile.build_social_profile(profile_params[:social_profile_attributes])
    if @profile.save!
      # session[:id] = current_user.id # ログイン状態維持のためuser_idをsessionに保存
      redirect_to root_path
    else
      render '/signups/step1'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :user_id,
      :name,
      :introduction,
      :prefecture_id,
      :web,
      :avatar,
      :avatar_cache,
      social_profile_attributes: [
        :id,
        :twitter,
        :instagram,
        :youtube,
        :line,
        :apple,
        :spotify
      ]
    )
  end

end
