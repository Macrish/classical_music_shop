Rails.application.routes.draw do
  root 'main#welcome'

  resources :composers, only: [:index] do
    resources :works, only: [:index]
  end

  resources :works, only: [:index] do
    resources :editions, only: [:index, :show]
  end
end
