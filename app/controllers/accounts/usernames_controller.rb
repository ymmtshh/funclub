class Accounts::UsernamesController < ApplicationController
    before_action :authenticate_user!

    def edit
    end

    def update
        if current_user.update(user_params)
            redirect_to account_path, notice: 'ユーザーネームを変更しました'
        else
            redirect_to edit_account_username_path, notice: 'ユーザーネームを変更できませんでした'
        end
    end

    # def password_required?
    #     super && provider.blank?  # provider属性に値があればパスワード入力免除
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(
            :username
        )
    end
end
