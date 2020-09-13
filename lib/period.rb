class Period
  attr_accessor :name, :start_date, :end_date
  attr_reader :countries

  PERIOD = {[1650..1750, %w{ EN DE FR IT ES NL}] => "Baroque",
            [1751..1810, %w{ EN DE IT NL}]       => "Classical",
            [1751..1830, %w{ FR }]               => "Classical",
            [1837..1901, %w{ EN }]               => "Victorian",
            [1820..1897, %w{ DE FR}]             => "Romantic"}
  def initialize
    self.countries = []
  end

  def period
    pkey = PERIODS.keys.find do |yrange,countries|
      yrange.include?(year) && countries.include?(country)
    end
    PERIODS[pkey] || century
  end
end

# period = Period.new
# period.name = "Baroque"
# period.start_date = 1650
# period.end_data = 1750
# period.countries = %w{ EN DE FR IT ES NL }
#
# нужен хэш по типу
# [1650..1750, %w{ EN DE FR IT ES NL }] => "Baroque"