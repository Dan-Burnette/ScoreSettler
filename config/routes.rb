Rails.application.routes.draw do
  devise_for :users

  resources :users, :except => [:index]
  resources :groups
  resources :memberships
  resources :tournaments do
    resources :matches
  end

  resources :invites

  root to: 'users#show'




  
end
