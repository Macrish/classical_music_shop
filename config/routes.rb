Rails.application.routes.draw do

  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :api
  draw :main
  
  get '/instruments/:id', to: 'instruments#show', as: 'instrument'

  resources :composers, only: [:index, :show] do
    resources :works, only: [:index]
  end

  resources :works, only: [:index, :show] do
    resources :editions, only: [:index, :show]
  end

end
