class Edition < ApplicationRecord
  before_create :self_description
  belongs_to :work

  def self_description
    self.description = 'standard' unless description
  end
end
