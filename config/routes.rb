Rails.application.routes.draw do
  get 'admin/user'
  get 'admin/index'
  get '/deactive', to: "admin#deactivate"
  get '/undeactivate', to: "admin#undeactivate"
  get 'reviews/show'

  get 'admin/suggest_list'
  match '/suggest_confirm/:id', to: "admin#suggest_confirm", via: [:get, :post], as: :suggest_confirm
  get "/add_review", to: "reviews#add"
  get "/like_review", to: "reviews#like_review"
  get 'reviews/remove'
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'static_pages#home'
  get 'static_pages/home'
  match '/search', to: "static_pages#search", via: [:get, :post], as: :search
  get '/top_rating', to: 'static_pages#top_rating', as: :top_rating
  get '/showing', to: 'static_pages#showing', as: :showing
  get '/show_soon', to: 'static_pages#show_soon', as: :show_soon
  resources :movies
  resources :users, only: [:show, :edit]
end
