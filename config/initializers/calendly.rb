Calendly.configure do |config|
  config.token = Rails.application.secrets['calendly_key']
end

