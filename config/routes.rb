Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles

  root 'static_pages#home'

  get '/fiasco', to: 'static_pages#fiasco'
  get '/signup', to: 'users#new'

end
