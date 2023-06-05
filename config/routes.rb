Rails.application.routes.draw do
  root 'time_cards#index'
  
  devise_for :companies, controllers: {
    sessions: 'companies/sessions',
    passwords: 'companies/passwords',
    registrations: 'companies/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :time_cards do
    member do
      patch :leaving_work
    end
    collection do
      post :starting_work
    end
  end
  resources :users, only: %i[index show edit update]
  resources :shift_types, only: [:new, :create, :index, :edit, :update, :destroy]
end
