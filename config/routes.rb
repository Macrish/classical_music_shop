Rails.application.routes.draw do
  root 'main#welcome'
  resources :composers do
    resources :works, only: [:index] do
      resources :editions, only: [:index, :show]
    end
  end
end
