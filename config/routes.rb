Rails.application.routes.draw do
  devise_for :users

  resources :users, :except => [:index]
  resources :groups
  resources :memberships
  resources :tournaments do
    resources :matches
  end


  root to: 'users#show'

  get '/groups/:id/head_to_head', to: 'groups#head_to_head'



  
end
