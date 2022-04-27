class ProfilesController < ApplicationController
    # before_action :authenticate_user!, except: [:show]
    before_action :set_profile

    def show
    end

    def edit
    end

    def update
        if @profile.update(profile_params)
            redirect_to user_path(current_user), notice: "プロフィールを更新しました。"
        else
            render :edit
        end
    end

    private
    def set_profile
        @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(
            :user_id,
            :name,
            :introduction,
            :prefecture_id,
            :web,
            :avatar,
            :avatar_cache,
            :remove_avatar,
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
