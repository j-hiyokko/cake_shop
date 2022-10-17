Rails.application.routes.draw do

  root to: "homes#top"
  get "/about" => "homes#about", as: 'about'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'pubulic/sessions'
  }
scope module: :public do
  resources :items, only: [:index,:show]
  resource :customers, only: [:show,:edit,:update,:cofirm,:withdraw]
  resources :cart_items, only: [:index,:update,:destroy,:destroy_all,:create]
  resources :orders, only: [:new,:confirm,:complete,:create,:index,:show]
  resources :addresses, only: [:index,:edit,:create,:update,:destroy]
end

namespace :admin do
  get "/" => "homes#top"
  resources :items, only: [:index,:new,:create,:show,:edit,:update]
  resources :genres, only: [:index,:create,:show,:edit,:update]
  resources :customers, only: [:index,:show,:edit,:update]
  resources :orders, only: [:show,:update]
  resources :products, only: [:update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
