class Accounts::PasswordsController < ApplicationController
    before_action :authenticate_user!

    def edit
    end

    def update
        if current_user.update_with_password(user_params)
            sign_in(current_user, bypass: true)
            redirect_to account_path, notice: 'パスワードを変更しました'
        else
            redirect_to edit_account_password_path, notice: 'パスワードを変更できませんでした'
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(
            :password,
            :password_confirmation,
            :current_password
        )
    end
end
