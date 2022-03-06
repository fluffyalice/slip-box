Rails.application.routes.draw do

  resources :tag_links
  resources :branch_links
  resources :types
  resources :tags
  resources :references
  resources :notes
  mount EpiCas::Engine, at: "/"
  devise_for :users
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "notes#index"
  get '/dashboard/references', to:'pages#reference_manager'
  get '/dashboard/categories', to: 'pages#types_manager'
  get '/dashboard/tags', to: 'pages#tags_manager'
  get '/dashboard/info', to: 'pages#info'
  post '/notes/search', to: 'notes#search'
  post '/notes/actions_manager', to: 'notes#actions_manager'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
