Rails.application.routes.draw do
  get 'admin/user' 
  get 'admin/review' ,to: "admin#commentdelete"
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
  resources :movies
  resources :users, only: [:show, :edit]
end
