Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #電話驗證
  resources :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"
  

  #信貸試算部分
  match 'phone_numbers/sitemap' , :defaults => { :format => 'xml' }
  get "basic", to: "cathaybk#basic"
  post "basic_submit", to: "cathaybk#basic_submit"
  get "credit", to: "cathaybk#credit"
  post "credit_submit", to: "cathaybk#credit_submit"
  get "situation", to: "cathaybk#situation"

  get "get_time", to: "cards#get_time"

  #google地圖部分
  get "user_pos", to: "cathaybk#user_pos"
  get "pos", to: "cathaybk#pos"
  get "cathaybk", to: "cathaybk#index"
  resource :addresslanlng
  resources :cathaybk
  
  #預約號碼排
  resources :cards do
    member do
      post :take
    end
  end

  
  
 root "phone_numbers#new"

  #號碼牌管理
  namespace :admin do
    resources :cards do
      put :sort, on: :collection
      member do
        post :remind
      end
    end
    root "cards#index"
  end


end
