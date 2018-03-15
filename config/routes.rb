Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "basic", to: "cathaybk#basic"
  get "cathaybk", to: "cathaybk#index"
  resources :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"

  root "phone_numbers#new"


end
