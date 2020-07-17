class EditionsController < ApplicationController
  before_action :set_edition, only: [:index, :show]

  def index
    @editions = @work.editions
  end

  def show
    @edition = @work.editions.find(params[:id])
  end

  private

  def set_edition
    @composer = Composer.find(params[:composer_id])
    @work = @composer.works.find(params[:work_id])
  end
end
