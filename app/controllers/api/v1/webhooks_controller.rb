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
      send_mail_for_event_deletion


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

  def send_mail_for_event_deletion
    mg_client = Mailgun::Client.new Rails.application.secrets['mailgun'][:key]
    message_params =  { from:    "info@sbdcbahamas.com",
                        to:      'info@sbdcbahamas.com',
                        subject: "Delete Calendly Event!",
                        text:    ("Remove calendly event as the invitee profile is not present in our app.").html_safe
                      }

    mg_client.send_message Rails.application.secrets['mailgun'][:domain], message_params
  end

  def send_mail_to_invitee
    mg_client = Mailgun::Client.new Rails.application.secrets['mailgun'][:key]
    message_params =  { from:    "info@sbdcbahamas.com",
                        to:      calendly_invitee_email,
                        subject: "Calendly Event Cancelled!",
                        text:    ("Your calendly event/meeting gets cancelled! Please register here(https://www.sbdcbahamas.com) first to continue using calendly meetings!").html_safe
                      }

    mg_client.send_message Rails.application.secrets['mailgun'][:domain], message_params
  end

  private
    def calendly_invitee_email
      params[:payload][:invitee][:email]
    end
end
