Rails.application.routes.draw do

  namespace :public do
    get 'genres/show'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
scope module: :public do
  root to: "homes#top"
  get "/about" => "homes#about", as: 'about'
  resources :items, only: [:index,:show]
  resource :customers, only: [:show,:cofirm]
  get 'customer/edit' => 'customers#edit'
  put 'customer/update' => 'customers#update'
  patch 'customer/update' => 'customers#update'


  get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'


  resources :cart_items, only: [:index,:update,:destroy,:destroy_all,:create] do
    collection do
      delete 'destroy_all'
    end
  end
  post 'orders/confirm'=>'orders#confirm', as: 'confirm_order'
  get 'orders/complete'=>'orders#complete',as: 'complete_order'
  resources :orders, only: [:new,:create,:index,:show]
  resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  resources :genres, only:[:show]
end

namespace :admin do
  get "/" => "orders#index"
  resources :items, only: [:index,:new,:create,:show,:edit,:update]
  resources :genres, only: [:index,:create,:edit,:update,:destroy]
  resources :customers, only: [:index,:show,:edit,:update]
  resources :orders, only: [:show,:update,:index]
  resources :order_detailes, only: [:update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
