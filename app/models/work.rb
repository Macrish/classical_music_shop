class Work < ApplicationRecord
  belongs_to :composer
  has_and_belongs_to_many :instruments
  # to return editions in ascending order by year
  has_and_belongs_to_many :editions, order: 'year ASC'

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

  def key
    kee
  end
end
