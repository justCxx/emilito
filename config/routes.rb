Rails.application.routes.draw do
  use_doorkeeper

  root 'rails/welcome#index'

  namespace :api do
    namespace :v3 do
      resources :workspaces do
        resources :tickets, except: [:new, :edit]
        resources :users
        resources :webhooks
      end
    end
  end

  get '404', to: 'api/errors#not_found'
  get '406', to: 'api/errors#not_acceptable'
  get '500', to: 'api/errors#internal_server_error'
end
