class ProfilesController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :set_profile

    # def show
    # end

    def edit
    end

    def update
        respond_to do |format|
            if @profile.update(profile_params)
                format.html {
                    redirect_to user_path(current_user),
                    notice: "プロフィールを更新しました"
                }
            else
                format.html {
                    render :edit
                }
            end
        end
    end

    private
    def set_profile
        @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(
            :name,
            :introduction,
            :location,
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
