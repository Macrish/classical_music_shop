module Api
  class ComposersController < ApplicationController
    def index
      composers = Composer.all.order("last_name ASC")
      render json: {status: 'SUCCESS', message: 'Loaded composers', data: composers}, status: :ok
    end

    def show
      composer = Composer.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Loaded composer', data: composer}, status: :ok
    end
  end
end
