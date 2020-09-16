module InstrumentsHelper
  def link_to_instrument(instrument)
    link_to(instrument.name, instrument_path(instrument))
  end
end
