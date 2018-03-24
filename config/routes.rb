Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "basic", to: "cathaybk#basic"
  post "basic_submit", to: "cathaybk#basic_submit"
  get "credit", to: "cathaybk#credit"
  post "credit_submit", to: "cathaybk#credit_submit"

  get "/delete_session", to: "cathaybk#delete_session"
  get "situation", to: "cathaybk#situation"
  get "cathaybk", to: "cathaybk#index"
  resources :cathaybk
  resources :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"

  root "phone_numbers#new"


end
