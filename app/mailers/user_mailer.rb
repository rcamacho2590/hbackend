class UserMailer < ActionMailer::Base
  default from: "info@hubble.com"

  def reset_password_email(user)

    @user = user
    @url  = 'http://codeHero.co'
    mail(to: @user[:email], subject: 'Reset password instructions')
  end

end
