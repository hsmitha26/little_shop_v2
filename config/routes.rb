Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # PUBLIC PAGE ROUTES
  # root to: "welcome#index"
  get '/', to: "welcome#index", as: :root

  # resources :items, only: [:index, :show]
  get '/items', to: "items#index"
  get '/items/:id', to: "items#show", as: :item

  get '/merchants', to: "merchants#index"

  # NEW USER REGISTRATION ROUTES
  get '/register', to: "users#new"
  # resources :users, only: [:create]
  post '/users', to: "users#create", as: :users

  # LOGIN/LOGOUT ROUTES
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  # CART ROUTES
  scope :cart, as: :cart do
    get '/', to: "carts#show"
    delete '/', to: "carts#destroy"
    post '/', to: 'carts#checkout'
    post '/:id', to: 'carts#add_from_show_page',  as: :add_item
    patch '/:id/increment', to: 'carts#increment', as: :increment_item
    patch '/:id/decrement', to: 'carts#decrement', as: :decrement_item
    patch '/:id/remove', to: 'carts#remove_item', as: :remove_item
  end

  # PROFILE ROUTES (AS A USER)
  scope :profile, module: :user, as: :profile do
    get '/', to: "users#show"
    patch '/', to: "users#update"
    get '/edit', to: "users#edit"
  end

  scope :profile, module: :user, as: :user do
    # resources :orders, only: [:index, :show]
    get '/orders', to: "orders#index", as: :orders
    get '/orders/:id', to: "orders#show", as: :order
    patch '/orders/:id/cancel', to: 'orders#cancel', as: :cancel_order
  end

  # DASHBOARD ROUTES (AS A MERCHANT)
  scope :dashboard, module: :merchant, as: :merchant do
    get '/', to: "merchants#show", as: :dashboard
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    patch '/items/:id/disable', to: "items#disable", as: :disable_item
    patch '/items/:id/enable', to: "items#enable", as: :enable_item
    patch '/order_items/:id/fulfill', to: 'order_items#fulfill', as: :fulfill_item
    resources :orders, only: :show
  end

  # ADMIN ROUTES
  namespace :admin do
    get '/dashboard', to: "admins#show"
    patch '/dashboard', to: "admins#ship_order"
    resources :merchants, only: [:index, :show]
    patch '/merchants/:id/disable', to: "merchants#disable", as: :disable_merchant
    patch '/merchants/:id/enable', to: "merchants#enable", as: :enable_merchant
    patch '/merchants/:id/downgrade', to: "merchants#downgrade", as: :downgrade_merchant

    resources :users, only: [:index, :show]
    patch '/users/:id/upgrade', to: "users#upgrade", as: :upgrade_user
  end
end
