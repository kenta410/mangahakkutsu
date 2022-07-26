Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root :to =>"homes#top"
    get "home/about" => "homes#about"
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'

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


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
