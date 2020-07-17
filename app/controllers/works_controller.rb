class WorksController < ApplicationController
  def index
    @composer = Composer.find(params[:composer_id])
    @works = @composer.works.order(title: :asc)
  end
end
