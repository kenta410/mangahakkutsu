Rails.application.routes.draw do

  namespace :admin do
    get 'comics/show'
    get 'comics/index'
    get 'comics/edit'
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root :to =>"homes#top"
    get "home/about" => "homes#about"

    resources :comics, only: [:index, :show, :edit, :create, :destroy, :update] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
    get '/search', to: 'searches#search'
  end

  namespace :admin do
    resources :customers, only: [:index, :edit, :update, :show, :destroy]
    resources :comics, only: [:index, :show, :edit, :create, :destroy, :update] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get '' => 'homes#top', as: 'admin'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
