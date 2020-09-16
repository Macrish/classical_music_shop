Rails.application.routes.draw do
  root 'main#welcome'

  resources :composers, only: [:index, :show] do
    resources :works, only: [:index]
  end

  resources :works, only: [:index, :show] do
    resources :editions, only: [:index, :show]
  end
end
