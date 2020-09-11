class Work < ApplicationRecord
  belongs_to :composer
  has_many :editions
  has_and_belongs_to_many :instruments
  # to return editions in ascending order by year
  has_and_belongs_to_many :editions, order: 'year ASC'
end
