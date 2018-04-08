Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "basic", to: "cathaybk#basic"
  post "basic_submit", to: "cathaybk#basic_submit"
  get "credit", to: "cathaybk#credit"
  post "credit_submit", to: "cathaybk#credit_submit"

  get "/delete_session", to: "cathaybk#delete_session"
  get "situation", to: "cathaybk#situation"
  get "user_pos", to: "cathaybk#user_pos"
  get "pos", to: "cathaybk#pos"
  get "cathaybk", to: "cathaybk#index"
  resources :cathaybk
  resources :phone_numbers, only: [:new, :create]
  resources :cards do
    member do
      post :take
    end
  end

  resource :addresslanlng

  post "cathaybk/result", to: "cathaybk#result"
  post 'phone_numbers/verify' => "phone_numbers#verify"

  root "phone_numbers#new"


  namespace :admin do
    resources :cards do
      put :sort, on: :collection
      member do
        post :remind
      end
    end

  end


end
