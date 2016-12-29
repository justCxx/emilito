# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  use_doorkeeper

  root 'web/static_pages#index'

  namespace :api do
    namespace :v3 do
      resources :workspaces do
        resources :tickets, except: [:new, :edit]
        resources :users
      end
    end
  end

  namespace :web_auth, path: :auth do
    scope controller: :authentication do
      post :user_auth
    end
  end

  scope module: :web do
    scope controller: :sessions do
      get    '/sign_in',  action: :new
      post   '/sign_in',  action: :create
      delete '/sign_out', action: :destroy
    end

    scope controller: :sign_up do
      get  '/sign_up', action: :new
      post '/sign_up', action: :create
    end

    scope controller: :static_pages do
      get :personal
      get :open_source
      get :business
      get :explore
      get :pricing
      get :blog
      get :support
    end

    scope module: :accounts do
      get '/dashboard', to: 'dashboard#show'
    end
  end

  get '404', to: 'api/errors#not_found'
  get '406', to: 'api/errors#not_acceptable'
  get '500', to: 'api/errors#internal_server_error'
end
