# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  authenticated :user do
    root to: 'posts#index'
  end

  root to: redirect('/users/sign_in')

  get 'chatroom/show'
  get 'users/0' => redirect('/')
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :comments

  resources :users
  resources :posts

  get '/search' => 'searches#search', :as => 'search_page'
  get '/:username' => 'users#show'
  post '/users/find', to: 'users#find'

  post '/post/index', to: 'comments#create'
end
