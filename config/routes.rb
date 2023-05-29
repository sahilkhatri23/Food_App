Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end

  # get '/show', to: 'franchises#show'
  # get '/index', to: 'franchises#index'
  get '/show_all_franchise', to: 'franchises#show_all_franchise'
  get '/show_all_menu_items', to: 'menu_items#show_all_menu_items'
  resources :franchises
  resources :menu_items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "franchises#index"
end
