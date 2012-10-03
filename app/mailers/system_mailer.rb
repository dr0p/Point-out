class SystemMailer < ActionMailer::Base
  default from: "point.it.mail@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "localhost:3000/log_in"
    mail(:to => user.email, :subject => "The Destiny Is Nearby Your Doorstep!")

  end
end
