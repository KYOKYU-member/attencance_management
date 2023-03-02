Rails.application.routes.draw do
  root 'time_cards#new'
  devise_for :users

  resources :time_cards
  resources :users, only: %i[new index]
end
