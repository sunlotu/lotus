class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_changed.subject
  #
  def password_changed(uid)
    @user = User.find(uid)
    mail to: @user.email, subject: '密码重置'
  end
end
