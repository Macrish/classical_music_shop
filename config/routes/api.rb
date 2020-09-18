namespace 'api' do
  resources :composers, only: %i[index show]
end