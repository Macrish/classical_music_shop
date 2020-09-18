class WorksController < ApplicationController
  def index
    @composer = Composer.find(params[:composer_id])
    @works = @composer.works.order(title: :asc)
  end

  def show
    @work = Work.find(params[:id])
  end
end
