Rails.application.routes.draw do
  devise_for :users

  resources :users, :except => [:index]
  resources :groups
  resources :memberships
  resources :tournaments do
    resources :matches
  end

  get 'head_to_head/:id', to: 'groups#ajax_head_to_head'

  root to: 'users#show'

  
end
