Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles
  resources :users

  root 'static_pages#home'

  get '/signup',    to: 'users#new'
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  get '/logout',    to: 'sessions#destroy'

end
