class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    #record内にユーザ情報が格納されている。"unconfirmed_email"の有無で登録／変更を分離
    #opts属性を上書きすることで、Subjectやfromなどのヘッダー情報を変更可能
    if record.unconfirmed_email != nil
      opts[:subject] = "メールアドレスの変更手続きを完了してください"
    else
      opts[:subject] = "ユーザー認証を行い登録を完了してください"
    end
    #件名の指定以外は親を継承
    super
  end

  # def confirmation_on_create_instructions(record, token, opts = {})
  #   @token = token
  #   devise_mail(record, :confirmation_on_create_instructions, opts)
  # end

end
