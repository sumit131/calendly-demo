class Api::V1::WebhooksController < ApplicationController
  require 'mailgun-ruby'

  def setup_subscription
    data = {}
    data[:url] = Rails.application.secrets['server_url'] + '/api/v1/invitee_created'
    data[:events] = ['invitee.created', 'invitee.canceled']
    @subscriptions = Calendly.webhook_subscription(data)
    puts @subscriptions
    session[:subscription] = @subscriptions
    redirect_to root_path
  end

  def check_subscription
    @subscriptions = Calendly.webhook_subscriptions
    puts @subscriptions
    session[:subscriptions] = @subscriptions
    redirect_to root_path
  end

  # def delete_event
  #   Calendly.delete_webhook
  # end

  def calendly_invitee_created
    puts "Webhook call received for event created by #{calendly_invitee_email}"
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
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new Rails.application.secrets['mailgun']['key']

    # Define your message parameters
    message_params =  { from: 'deepakyuvasoft234@gmail.com',
                        to:   'deepakyuvasoft234@gmail.com',
                        subject: 'The Mailgun mailer SDK is awesome!',
                        text:    'It is really easy to send a message!'
                      }

    # Send your message through the client
    mg_client.send_message Rails.application.secrets['server_url'], message_params
  end

  private
    def calendly_invitee_email
      params[:payload][:invitee][:email]
    end
end
