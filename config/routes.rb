Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about' , as: 'about'

    resources :items, only: [:index, :show]

    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/information' => 'customers#update'
    patch '/customers/withdraw' => 'customers#withdraw'

    patch '/cart_items/:id' => 'cart_items#update'
    resources :cart_items, only: [:index, :destroy, :create] do
    # 追加
    collection do
    delete 'destroy_all'
    end
    end
    # 削除
    # delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    get '/orders/new' => 'orders#new'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    post '/orders' => 'orders#create'
    resources :orders, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_histories, only: [:update]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
