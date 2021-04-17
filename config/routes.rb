Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "prototypes#index"

  resources :prototypes do  #tweets本文にcommentsのコメントを作るようにしているので、次はrails g controller commentsを作成
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  
end
