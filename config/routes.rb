Rails.application.routes.draw do
  devise_for :users

  resources :users, :except => [:index]
  resources :groups

  resources :tournaments do
    resources :matches
  end

  resources :invites

  root to: 'users#show'

  put '/invite', to: 'users#invite'


  
end
