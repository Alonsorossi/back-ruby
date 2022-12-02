class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
