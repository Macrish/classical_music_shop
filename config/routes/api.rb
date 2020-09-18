namespace 'api' do
  resources :composers, only: %i[index show]

  resources :works, only: [:index] do
    resources :editions, only: [:index, :show]
  end
end