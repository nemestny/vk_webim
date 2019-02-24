Rails.application.routes.draw do
  root to: 'home#index'
  
  get 'login', to: 'sessions#new'
  get 'callback', to: 'sessions#callback'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
