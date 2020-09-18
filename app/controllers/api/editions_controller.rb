module Api
  class EditionsController < ApplicationController
    before_action :set_work, only: [:index, :show]

    def index
      editions = @work.editions
      render json: { font_package: editions }, status: :ok
    end

    def show
      edition = @work.editions.find(params[:id])
      render json: { font_package: edition }, status: :ok
    end

    private

    def set_work
      @work = Work.find(params[:work_id])
    end
  end
end