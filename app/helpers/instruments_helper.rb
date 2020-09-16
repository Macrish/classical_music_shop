module InstrumentsHelper
  def link_to_instrument(instrument)
    link_to(instrument.name, instruments_show_path(instrument))
  end
end
