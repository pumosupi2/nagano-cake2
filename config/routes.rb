Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  root to: 'homes#top'
  get 'home/about' => 'homes#about' , as: 'about'
  
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
      get 'customers/unsubscribe' => 'customers#unsubscribe'
      patch 'customers/withdraw' => 'customers#withdraw'
    resources :cart_items, only: [:index, :updete, :destroy, :create]
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
      get 'orders/complete' => 'orders#complete'
      post 'orders/confirm' => 'orders#confirm'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_histories, only: [:update]
  end
  
  
    

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
