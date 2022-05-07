class ProfilesController < ApplicationController
    # before_action :authenticate_user!, except: [:show]
    before_action :set_profile

    def show
    end

    def new
    end

    def create
    end

    def edit
        @profile = Profile.find(params[:id])
        @profile.social_profile
        @profile.genre_ids = @profile.genres.pluck(:id)
    end

    def update
        @profile = Profile.find(params[:id])
        old_genres = @profile.genres.pluck(:genre_id)
        if @profile.update(profile_params)
            if profile_params[:genre_ids].nil?
                genres = ProfileGenre.where(profile_id: @profile.id)
                genres.destroy_all
            else
                destroy_genres = old_genres - profile_params[:genre_ids].map(&:to_i)
                destroy_genres.each do | destroy_genre |
                genre = ProfileGenre.find_by(profile_id: @profile.id, genre_id: destroy_genre)
                genre.destroy
            end
                genres = @profile.genres.pluck(:genre_id)
                profile_params[:genre_ids].each do | profileg |
                    unless genres.include?(profileg.to_i)
                    genre = ProfileGenre.new(genre_id: profileg)
                    genre.profile_id = @profile.id
                    genre.save
                    end
                end
            end
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
        genre_ids: [],
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
