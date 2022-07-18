Rails.application.routes.draw do
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
    resources :users, only: %i[show edit update]
    resources :posts, only: %i[new show index edit create destroy update] do
      resource :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :posts, only: %i[show index destroy]
    resources :users, only: %i[show index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
