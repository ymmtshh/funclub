class ContactMailer < ApplicationMailer

  def send_mail(contact)
    @contact = contact
    @user = @contact.user_id
    mail(to: @contact.user.email, subject: '【お問い合わせ】' + @contact.subject_i18n)
  end
end
