# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    get 'me' => 'authentication#me'
    post 'login' => 'authentication#login'
    post 'join' => 'users#create'
    patch 'me' => 'users#update'

    scope 'dreambook', controller: :dreambook do
      get '/' => :index, as: :dreambook_index
      get '/:letter' => :letter, as: :dreambook_letter
      get '/:letter/:name' => :show, as: :dreambook_pattern
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
