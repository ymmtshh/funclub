require 'rails_helper'

RSpec.describe 'Users', type: :system do
  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end  

  before do
    @user = FactoryBot.build(:user)
  end

    context 'ユーザーが新規登録するとき' do
      it '登録情報入力後、認証メールが送信され、パスワードを登録するとトップページに移動する' do
        # 新規登録ページに移動
        visit new_user_registration_path
        # ユーザー情報を入力
        fill_in 'ユーザー名', with: @user.username
        fill_in 'メールアドレス', with: @user.email
        expect{click_on('アカウントを作成する')}.to change { ActionMailer::Base.deliveries.size }.by(1)

        # メール本文からtokenを取得
        mail = ActionMailer::Base.deliveries.last
        token = mail.body.encoded[/(?<=user_confirmation\/)[^\/]+/]
        p token
        # 認証メールに記載のリンク先に移動
        visit user_confirmation_path(confirmation_token: @user.confirmation_token)
        # パスワードを入力
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード（確認）', with: @user.password_confirmation
        expect{click_on('登録')}.to change { User.count }.by(1)

        expect(current_path).to eq root_path
      end
    end
  end