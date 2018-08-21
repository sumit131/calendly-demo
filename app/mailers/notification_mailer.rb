class NotificationMailer < ApplicationMailer

  def notify_user(email)
    debugger
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end 

end