Rails.application.routes.draw do
  # get 'instruments/show'
  root 'main#welcome'
  get 'main/home'
  get 'main/view_cart'
  get 'main/show_period'

  get '/instruments/:id', to: 'instruments#show', as: 'instrument'

  resources :composers, only: [:index, :show] do
    resources :works, only: [:index]
  end

  resources :works, only: [:index, :show] do
    resources :editions, only: [:index, :show]
  end
end
