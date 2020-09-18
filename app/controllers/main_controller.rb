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
    @period = params[:format]
    return if @period.nil?

    works = Work.all.select do |work|
      # (work.period(work.year, work.country) == @period) || (work.century == @period)
      (work.period(work.year, work.country) == @period)
    end
    @editions = Edition.of_works(works)
  end
end
