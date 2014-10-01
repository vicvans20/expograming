Rails.application.routes.draw do
 root to: 'pages#index'
 get '/about', to: 'pages#about', as: 'pages_about'
 get '/feedback', to: 'feedbacks#new', as: 'feedbacks_new'
 resources :feedbacks, only: [:new, :create]
end
