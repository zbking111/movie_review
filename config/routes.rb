Rails.application.routes.draw do
  get 'admins/index'
  get 'reviews/show'
  get "/add_review", to: "reviews#add"
  get 'reviews/remove'
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'static_pages#home'
  get 'static_pages/home'
  match '/search', to: "static_pages#search", via: [:get, :post], as: :search
  resources :movies
  resources :users, only: [:show, :edit]
end
