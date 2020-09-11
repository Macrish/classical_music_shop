class Work < ApplicationRecord
  belongs_to :composer
  has_many :editions
  has_and_belongs_to_many :instruments
end
