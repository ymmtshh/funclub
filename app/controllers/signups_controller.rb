class SignupsController < ApplicationController

  def step1
    @user = User.find(current_user.id)
    @profile = Profile.new # 新規インスタンス作成
  end

  def step2
    # step1で入力した値をsessionに保存
    session[:name] = profile_params[:name]
    session[:introduction] = profile_params[:introduction]
    session[:prefecture_id] = profile_params[:prefecture_id]
    session[:web] = profile_params[:web]
    session[:avatar] = profile_params[:avatar]
    @user = User.find(current_user.id)
    @profile = Profile.new # 新規インスタンス作成
    @profile.build_social_profile
  end
  
  def step3
    # step2で入力した値をsessionに保存
    session[:social_profile] = profile_params[:social_profile]
    @user = User.find(current_user.id)
    @profile = Profile.new # 新規インスタンス作成
    @profile.profile_genres.build
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
    )
    @profile.build_social_profile(session[:social_profile])
    if @profile.save!
      profile_params[:genre_ids].each do | profileg |
        genres = @profile.genres.pluck(:genre_id)
        unless genres.include?(profileg.to_i)
          genre = ProfileGenre.new(genre_id: profileg)
          genre.profile_id = @profile.id
          genre.save
        end
      end
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
      genre_ids: [],
      social_profile: [
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
