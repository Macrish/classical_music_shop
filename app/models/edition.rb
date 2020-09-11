class Edition < ApplicationRecord
  before_create :self_description
  belongs_to :work
  belongs_to :publisher

  def self_description
    self.description = 'standard' unless description
  end
end
