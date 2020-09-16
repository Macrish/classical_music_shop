Rails.application.routes.draw do
  get 'instruments/show'
  root 'main#welcome'
  get 'main/home'
  get 'main/view_cart'

  resources :composers, only: [:index, :show] do
    resources :works, only: [:index]
  end

  resources :works, only: [:index, :show] do
    resources :editions, only: [:index, :show]
  end
end
