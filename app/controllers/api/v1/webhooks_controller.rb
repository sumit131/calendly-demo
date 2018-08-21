class Api::V1::WebhooksController < ApplicationController

  def setup_subscription
    data = {}
    data[:url] = Rails.application.secrets['server_url'] + '/api/v1/invitee_created'
    data[:events] = ['invitee.created', 'invitee.canceled']
    @hook = Calendly.webhook_subscription(data)
    # hook_id: {"id"=>249061, 249081}
  end

  def check_subscription
    Calendly.webhook_subscriptions
  end

  # def delete_event
  #   Calendly.delete_webhook
  # end

  def calendly_invitee_created
    if Profile.email_exist?(calendly_invitee_email)
      # do nothing
    else
      send_mail_to_invitee
      # Send mail to user, to created profile on our site.
      # Delete Event from calendly, (No documentation for the same)
    end
  end

  def calendly_invitee_canceled
    if Profile.email_exist?(calendly_invitee_email)
      # do nothing
    else
      send_mail_to_invitee
      # Send mail to user, to created profile on our site.
      # Delete Event from calendly, (No documentation for the same)
    end
  end

  def send_mail_to_invitee
    # Send mail with signup link via mailgum 
    # RestClient.post "https://api:6da3049628abe5735223636c11fc7b40-a4502f89-ab1ebc87"
    #     "@api.mailgun.net/v3/sandbox660b4b11e0654974b315e2b48a1663d3.mailgun.org/messages",
    #     :from => "Mailgun Sandbox <postmaster@sandbox660b4b11e0654974b315e2b48a1663d3.mailgun.org>",
    #     :to => "Deepak Yuvasoft <deepakyuvasoft234@gmail.com>",
    #     :subject => "Hello Deepak Yuvasoft",
    #     :text => "Congratulations Deepak Yuvasoft, you just sent an email with Mailgun!  You are truly awesome!"
  end

  private
    def calendly_invitee_email
      params[:payload][:invitee][:email]
    end
end
