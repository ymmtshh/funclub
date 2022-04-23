class ProfilesController < ApplicationController
    # before_action :authenticate_user!, except: [:show]
    before_action :set_profile

    def show
    end

    def edit
    end

    def update
        if @profile.update(profile_params)
            redirect_to profile_path(@profile), notice: "プロフィールを更新しました。"
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
            :city_id,
            :web,
            :avatar,
            :avatar_cache,
            :remove_avatar,
            :twitter,
            :instagram,
            :youtube,
            :line,
            :apple,
            :spotify,
        )
    end

end
