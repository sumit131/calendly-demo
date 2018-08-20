Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :profiles, only: [:create]
      get '/subscription', to: 'webhooks#setup_subscription'
      get '/check_subscription', to: 'webhooks#check_subscription'
      post '/invitee_created', to: 'webhooks#calendly_invitee_created'
      post '/invitee_canceled', to: 'webhooks#calendly_invitee_canceled'
    end
  end
end
