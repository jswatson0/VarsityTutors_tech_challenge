Rails.application.routes.draw do

  devise_for :customers
  root 'welcome#index'

  resources :orders, :customers

  get '/orders/:id/shipping_info' => 'orders#shipping_info', as: :order_shipping_info



end
