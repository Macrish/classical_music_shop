class InstrumentsController < ApplicationController
  helper :works, :editions

  def show
    @instrument = Instrument.find(params[:id])
  end
end
