class ContactsController < ApplicationController
  before_action :find_contact, only: [:show, :destroy]
  before_action :find_user, only: [:new, :back, :done]

  def show
  end

  def new
    @contact = Contact.new
  end
  
  # 確認画面を作成する場合はこのような記述になるかと思います。
  # newアクションから入力内容を受け取り、
  # 送信ボタンを押されたらcreateアクションを実行します。
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end
  
  # 入力内容に誤りがあった場合、
  # 入力内容を保持したまま前のページに戻るのが当たり前になっているかと思いますが、
  # backアクションを定義することで可能となります。
  def back
    @contact = Contact.new(contact_params)
    render :new
  end
  
  # 実際に送信するアクションになります。
  # ここで初めて入力内容を保存します。
  # セキュリティーのためにも一定時間で入力内容の削除を行ってもいいかもしれません。
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.with(user: @contact.user_id).send_mail(@contact).deliver_now
      redirect_to user_done_path(@contact.user_id)
    else
      render :new
    end
  end

  # 送信完了画面を使用する場合お使いください。
  def done
  end
  
  def destroy
    if @contact.destroy
      redirect_to contacts_user_path(@contact.user_id), notice: "お問い合わせを削除しました。"
    else
      redirect_to contacts_user_path(@contact.user_id), alert: "お問い合わせを削除できませんでした。"
    end
  end


  private
  def contact_params
    params.require(:contact).permit(
      :user_id,
      :email,
      :name,
      :phone_number,
      :subject,
      :message
    )
  end
  
  def find_contact
    @contact = Contact.find(params[:id])
  end
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
