Rails.application.routes.draw do

  devise_for :customers
  root 'welcome#index'



end
