class MainController < ApplicationController
  helper :works, :composers, :instruments

  def welcome
    @composers = Composer.all.sort_by do |composer|
      [composer.last_name, composer.first_name, composer.middle_name]
    end
    @instruments  = Instrument.all.order(name: :asc)
    @periods = Work.all_periods
  end

  def home; end

  def view_cart; end

  def show_period
    @period = params[:id]
    works = Work.all.select do |work|
      (work.period == @period) || (work.century == @period)
    end
    @editions = Edition.of_works(works)
  end
end
