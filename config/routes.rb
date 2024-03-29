Rails.application.routes.draw do
  namespace :public do
    get 'contacts/new'
  end
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: %i[index show edit update] do
      resource :relationships, only:[:create,:destroy]
      get "followings"=>"relationships#followings",as:"followings"
      get "followers"=>"relationships#followers",as:"followers"
    end
    resources :posts, only: %i[new show index edit create destroy update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create]
    resource :contacts, only: [:new, :create]
    post 'contacts/confirm' => 'contacts#confirm', as: :confirm
  end

  namespace :admin do
    root to: 'homes#top'
    resources :posts, only: %i[show index destroy]
    resources :users, only: %i[show index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
