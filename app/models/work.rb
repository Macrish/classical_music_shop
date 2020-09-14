class Work < ApplicationRecord
  belongs_to :composer
  has_and_belongs_to_many :instruments
  # to return editions in ascending order by year
  has_and_belongs_to_many :editions, order: 'year ASC'

  def nice_instruments
    instrs = instruments.map {|inst| inst.name }
    ordered = %w{ flute oboe violin viola cello piano orchestra }
    # сортировка по индексу
    instrs = instrs.sort_by {|i| ordered.index(i) || 0 }
    # также инструменты можно поместить в константу, но Конст будет
    # обновляться вручную
    case instrs.size
    when 0
      nil
    when 1
      instrs[0]
    when 2
      instrs.join(" and ")
    else
      instrs[0..-2].join(", ") + ", and " + instrs[-1]
    end
  end

  def publishers
    editions.map { |e| e.publisher }.uniq
  end

  def country
    composer.country
  end

  # doesn't work
  def ordered_by
    editions.orders.map { |o| o.customer }.uniq
  end

  # def key
  #   kee
  # end

  def nice_opus
    # если опус содержит только цифры
    if /^\d/.match(opus)
      "op. #{opus}"
    else
      opus
    end
  end

  #Sonata in F Major, op. 99, for cello and piano
  def nice_title
    t,k,o,i = title, key, nice_opus, nice_instruments
    "#{t} #{"in #{k}" if k}#{", #{o}" if o}#{", for #{i}" if i}"
  end

  def period(year, country)
    ::Period.new.period(year, country)
  end

  def self.all_periods
    Work.all.map {|work| work.period(work.year, work.composer.country) }.flatten.uniq.sort
  end
end
