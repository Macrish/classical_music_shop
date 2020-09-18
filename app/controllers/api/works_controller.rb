module Api
  class WorksController < ApplicationController
    def index
      works = Work.all
      render json: { font_package: works }, status: :ok
    end
  end
end