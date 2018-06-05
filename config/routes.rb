Rails.application.routes.draw do

  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :instagrams do
    collection do
      post :confirm
    end
  end

  resources :users,only: [:new, :create, :show]

  resources :sessions,only: [:new,:create,:destroy]

  resources :users

  resources :favorites,only: [:create, :destroy]

  resources :contacts
end
