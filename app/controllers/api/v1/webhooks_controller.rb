class Api::V1::WebhooksController < ApplicationController

  def setup_subscription
    data = {}
    data[:url] = 'https://03d6cb33.ngrok.io/api/v1/invitee_created'
    data[:events] = ['invitee.created', 'invitee.canceled']
    Calendly.webhook_subscription(data)
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
  end

  private
    def calendly_invitee_email
      params[:payload][:invitee][:email]
    end
end
