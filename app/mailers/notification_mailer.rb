class NotificationMailer < ApplicationMailer

  def notify_user(email)
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end 

end