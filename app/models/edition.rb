class Edition < ApplicationRecord
  before_create :self_description

  belongs_to :publisher
  has_and_belongs_to_many :works
  has_many :orders

  def self_description
    self.description = 'standard' unless description
  end
end
